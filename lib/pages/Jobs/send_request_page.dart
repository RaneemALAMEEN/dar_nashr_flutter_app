// lib/pages/jobs/send_request_page.dart
import 'dart:io';
import 'package:dar_nashr/core/resources/color.dart';
import 'package:dar_nashr/services/job_apply.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SendRequestPage extends StatefulWidget {
  final int vacancyId;
  final String jobTitle;
  const SendRequestPage({super.key, required this.vacancyId, required this.jobTitle});

  @override
  State<SendRequestPage> createState() => _SendRequestPageState();
}

class _SendRequestPageState extends State<SendRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _messageCtrl = TextEditingController();
  XFile? _picked; // من file_selector
  bool _submitting = false;

  @override
  void dispose() {
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final typeGroup = XTypeGroup(
      label: 'CV',
      extensions: ['pdf', 'doc', 'docx'],
      mimeTypes: ['application/pdf', 'application/msword',
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document'],
    );
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file != null) {
      setState(() => _picked = file);
    }
  }

  Future<void> _submit() async {
    if (_picked == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار ملف السيرة الذاتية')),
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      // حوّل XFile إلى File على المنصات التي تدعم مسار محلي
      // (على الويب _picked!.path قد يكون null؛ الـ Dio يدعم رفع bytes أيضًا إن احتجت)
      final path = _picked!.path;
      if (path == null || path.isEmpty) {
        // fallback: اقرأ bytes مباشرة (مفيد للويب)
        final bytes = await _picked!.readAsBytes();
        // خدمة بديلة بالـ bytes (اختياري). لكن على ويندوز/موبايل بيكون path موجود.
        // لتبسيط الشيفرة هنا نفترض ويندوز/موبايل: لازم path موجود.
        throw Exception('تعذر تحديد مسار الملف. جرّب على موبايل/ويندوز.');
      }

      final service = JobApplicationService();
      await service.applyToVacancy(
        vacancyId: widget.vacancyId,
        cvFile: File(path),
        coverLetter: _messageCtrl.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم إرسال الطلب إلى ${widget.jobTitle} بنجاح ✅')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل إرسال الطلب: $e'), backgroundColor: Colors.red),
      );
      print(e);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pickedName = _picked == null ? 'لم يتم اختيار ملف' : (_picked!.name);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                    ),
                    const Spacer(),
                    const Text(
                      'إرسال طلب',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),
                const Gap(12),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 110,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.textSecondaryC,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          controller: _messageCtrl,
                          maxLines: null,
                          expands: true,
                          decoration: const InputDecoration(
                            hintText: 'اكتب رسالة قصيرة لدار النشر... (اختياري)',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Gap(12),

                      Container(
                        width: double.infinity,
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.textSecondaryC,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.attach_file, size: 20, color: AppColors.primary),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                pickedName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: _pickFile,
                              icon: const Icon(Icons.file_upload_outlined, color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),

                      const Gap(20),

                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _submitting ? null : _submit,
                          child: _submitting
                              ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                              : const Text('إرسال', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
