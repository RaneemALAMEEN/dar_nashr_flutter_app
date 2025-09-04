import 'package:dar_nashr/core/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SendRequestPage extends StatefulWidget {
  final String jobTitle;
  const SendRequestPage({super.key, required this.jobTitle});

  @override
  State<SendRequestPage> createState() => _SendRequestPageState();
}

class _SendRequestPageState extends State<SendRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _messageCtrl = TextEditingController();
  final _attachmentCtrl = TextEditingController();

  @override
  void dispose() {
    _messageCtrl.dispose();
    _attachmentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      'إرسال طلب',
                      style: const TextStyle(
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
                      // مربع نص كبير (مثل فغما اليسرى)
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
                            hintText: 'اكتب رسالة قصيرة لدار النشر...',
                            border: InputBorder.none,
                          ),
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'الرسالة مطلوبة' : null,
                        ),
                      ),
                      const Gap(12),
                      // حقل مرفقات بسيط + زر رفع
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
                              child: TextFormField(
                                controller: _attachmentCtrl,
                                decoration: const InputDecoration(
                                  hintText: 'أرفق سيرة ذاتية / ملف (اختياري)',
                                  border: InputBorder.none,
                                ),
                                readOnly: true,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // لاحقاً منربط File Picker
                                setState(() {
                                  _attachmentCtrl.text = 'cv.pdf';
                                });
                              },
                              icon: const Icon(Icons.file_upload_outlined,
                                  color: AppColors.primary),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('تم إرسال الطلب إلى: ${widget.jobTitle}'),
                                ),
                              );
                              Navigator.pop(context); // رجوع لصفحة التفاصيل
                            }
                          },
                          child: const Text('إرسال',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
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
