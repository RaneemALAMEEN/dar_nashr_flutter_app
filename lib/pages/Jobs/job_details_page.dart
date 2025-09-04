import 'package:dar_nashr/core/resources/color.dart';
import 'package:dar_nashr/models/job_model.dart';

import 'package:dar_nashr/pages/jobs/send_request_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class JobDetailsPage extends StatelessWidget {
  final Job job;
  const JobDetailsPage({super.key, required this.job});

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
            text,
            style: const TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF374151)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      job.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
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
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // شريحة معلومات سريعة
                      Container(
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
                              Text(job.type, style: const TextStyle(color: Color(0xFF6B7280))),
                            ]),
                            Gap(10),
                            Row(children: [
                              const Icon(Icons.place_outlined, size: 18, color: Color(0xFF6B7280)),
                              const SizedBox(width: 6),
                              Text(job.location, style: const TextStyle(color: Color(0xFF6B7280))),
                            ]),Gap(10),
                            Row(children: [
                              const Icon(Icons.event_note, size: 18, color: Color(0xFF6B7280)),
                              const SizedBox(width: 6),
                              Text('آخر موعد: ${job.deadline}',
                                  style: const TextStyle(color: Color(0xFF6B7280))),
                            ]),
                          ],
                        ),
                      ),
                      const Gap(16),

                      _sectionTitle(Icons.description_outlined, 'وصف المهام'),
                      const Gap(8),
                      ...job.tasks.map(_bullet),
                      const Gap(18),

                      _sectionTitle(Icons.school_outlined, 'المؤهلات المطلوبة'),
                      const Gap(8),
                      ...job.requirements.map(_bullet),
                      const Gap(18),

                      if (job.salary != null) ...[
                        _sectionTitle(Icons.payments_outlined, 'الراتب'),
                        const Gap(8),
                        Text(job.salary!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, color: Color(0xff1D2A45))),
                        const Gap(18),
                      ],

                      const Gap(8),
                    ],
                  ),
                ),
              ),
              // زر إرسال طلب (سفلي مثل فغما)
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
                          builder: (_) => SendRequestPage(jobTitle: job.title),
                        ),
                      );
                    },
                    child: const Text('إرسال طلب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
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
