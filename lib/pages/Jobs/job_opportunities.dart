import 'package:dar_nashr/core/resources/color.dart';
import 'package:dar_nashr/core/widget/job_card.dart';
import 'package:dar_nashr/core/widget/job_map.dart';
import 'package:dar_nashr/pages/Jobs/job_details_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class JobOpportunitiesPage extends StatefulWidget {
  const JobOpportunitiesPage({super.key});

  @override
  State<JobOpportunitiesPage> createState() => _JobOpportunitiesPageState();
}

class _JobOpportunitiesPageState extends State<JobOpportunitiesPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = mockJobs
        .where((j) => j.title.contains(_query) || j.publisherName.contains(_query))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                // Top bar (قريب لفغما: شعار، فلتر)
                Row(
                  children: [
                    // زر فلترة شكلي
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list, color: AppColors.primary),
                    ),
                    const Spacer(),
                    const Text(
                      'فرص العمل',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu, color: AppColors.primary),
                    ),
                  ],
                ),
                const Gap(10),
                // شريط البحث مثل فغما
                TextField(
                  onChanged: (v) => setState(() => _query = v.trim()),
                  decoration: InputDecoration(
                    hintText: 'ابحث عن فرصة عمل...',
                    hintStyle: const TextStyle(fontSize: 12),
                    prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.primary),
                    filled: true,
                    fillColor: AppColors.textSecondaryC,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const Gap(12),
                    itemBuilder: (context, i) {
                      final job = filtered[i];
                      return JobCard(
                        title: job.title,
                        type: job.type,
                        location: job.location,
                        deadline: job.deadline,
                        onApply: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => JobDetailsPage(job: job),
                            ),
                          );
                        },
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => JobDetailsPage(job: job),
                            ),
                          );
                        },
                      );
                    },
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
