// lib/pages/Jobs/job_details_page.dart
import 'package:dar_nashr/core/resources/color.dart';
import 'package:dar_nashr/models/job_model.dart';
import 'package:dar_nashr/pages/jobs/send_request_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class JobDetailsPage extends StatelessWidget {
  final JobOpportunity job;
  const JobDetailsPage({super.key, required this.job});

  // عنوان قسم
  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: Color(0xff1D2A45),
          ),
        ),
      ],
    );
  }

  // عنصر نقطة
  Widget _bullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Icon(Icons.circle, size: 6, color: Color(0xFF6B7280)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text.trim(),
            style: const TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF374151)),
          ),
        ),
      ],
    );
  }

  // تنسيق تاريخ ISO لعرض اليوم فقط
  String _dateOnly(String iso) {
    if (iso.isEmpty) return '';
    final i = iso.indexOf('T');
    return i > 0 ? iso.substring(0, i) : iso;
  }

  // تفكيك المتطلبات (String) إلى نقاط
  List<String> _splitRequirements(String raw) {
    if (raw.trim().isEmpty) return [];
    // جرّب الفواصل الشائعة عربي/إنكليزي + أسطر
    final parts = raw
        .replaceAll('\r', '')
        .split(RegExp(r'[\n،,;•\-]+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    // إن ما طلع شي، رجّع النص كله كسطر واحد
    return parts.isNotEmpty ? parts : [raw.trim()];
  }

  @override
  Widget build(BuildContext context) {
    // مواءمة حقول الواجهة مع الـ API:
    final vacancyId=job.id;
    final title = job.position;                       // عنوان الوظيفة
    final type = job.publisherName.isEmpty ? 'غير مذكور' : job.publisherName; // "نوع" = اسم الدار
    final location = (job.publisherAddress?.isNotEmpty == true)
        ? job.publisherAddress!
        : 'غير مذكور';
    final deadline = _dateOnly(job.createdAt);        // ما في deadline بالـ API فنستخدم تاريخ الإنشاء
    final description = job.description;
    final reqBullets = _splitRequirements(job.requirements);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              // AppBar بسيط
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share, color: AppColors.primary),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    children: [
                      // بطاقة معلومات سريعة (نوع، موقع، تاريخ)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              const Icon(Icons.work_outline, size: 18, color: Color(0xFF6B7280)),
                              const SizedBox(width: 6),
                              Text(type, style: const TextStyle(color: Color(0xFF6B7280))),
                            ]),
                            const Gap(10),
                            Row(children: [
                              const Icon(Icons.place_outlined, size: 18, color: Color(0xFF6B7280)),
                              const SizedBox(width: 6),
                              Text(location, style: const TextStyle(color: Color(0xFF6B7280))),
                            ]),
                            const Gap(10),
                            Row(children: [
                              const Icon(Icons.event_note, size: 18, color: Color(0xFF6B7280)),
                              const SizedBox(width: 6),
                              Text('تاريخ النشر: $deadline',
                                  style: const TextStyle(color: Color(0xFF6B7280))),
                            ]),
                          ],
                        ),
                      ),
                      const Gap(16),

                      // الوصف
                      _sectionTitle(Icons.description_outlined, 'الوصف'),
                      const Gap(8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          description.isEmpty ? 'لا يوجد وصف متاح.' : description,
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 14, height: 1.6, color: Color(0xFF374151)),
                        ),
                      ),
                      const Gap(18),

                      // المتطلبات (كنقاط)
                      _sectionTitle(Icons.school_outlined, 'المتطلبات'),
                      const Gap(8),
                      if (reqBullets.isEmpty)
                        const Text('لا توجد متطلبات محددة.',
                            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)))
                      else
                        ...reqBullets.map(_bullet),

                      const Gap(8),
                    ],
                  ),
                ),
              ),

              // زر إرسال طلب
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SendRequestPage(jobTitle: title, vacancyId: vacancyId,),
                        ),
                      );
                    },
                    child: const Text(
                      'إرسال طلب',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
