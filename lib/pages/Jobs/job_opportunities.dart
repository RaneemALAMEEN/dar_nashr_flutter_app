// lib/pages/Jobs/job_opportunities_page.dart
import 'dart:async';
import 'package:dar_nashr/core/resources/color.dart';
import 'package:dar_nashr/core/widget/job_card.dart';
import 'package:dar_nashr/models/job_model.dart';
// عدلت الاستيراد ليتوافق مع اسم الملف اللي أرسلته
import 'package:dar_nashr/pages/Jobs/job_details_page.dart';
import 'package:dar_nashr/services/job_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class JobOpportunitiesPage extends StatefulWidget {
  const JobOpportunitiesPage({super.key});

  @override
  State<JobOpportunitiesPage> createState() => _JobOpportunitiesPageState();
}

class _JobOpportunitiesPageState extends State<JobOpportunitiesPage> {
  final _service = JobsService();
  final _searchCtrl = TextEditingController();
  final _focusNode = FocusNode();

  List<JobOpportunity> _all = [];
  List<JobOpportunity> _filtered = [];
  bool _loading = true;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _load();
    // حتى تتحدث أيقونة المسح فور تغيير النص
    _searchCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final res = await _service.getVacancies(skip: 0, limit: 50);
      if (!mounted) return;
      setState(() {
        _all = res;
        _filtered = res;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذّر تحميل فرص العمل'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// تطبيع النص العربي: إزالة التشكيل وتوحيد بعض الحروف لبحث أدق
  String _normalize(String input) {
    final s = input
        .trim()
        .toLowerCase()
        // إزالة التشكيل
        .replaceAll(RegExp(r'[\u064B-\u0652]'), '')
        // توحيد الألف
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        // توحيد الياء/الألف المقصورة
        .replaceAll('ى', 'ي')
        // توحيد الهاء/التاء المربوطة
        .replaceAll('ة', 'ه')
        // همزات شائعة
        .replaceAll('ؤ', 'و')
        .replaceAll('ئ', 'ي');
    return s;
  }

  /// ✅ التصفية حصراً حسب العنوان أو اسم دار النشر
  void _onSearchImmediate(String q) {
    final needle = _normalize(q);
    setState(() {
      _filtered = needle.isEmpty
          ? _all
          : _all.where((j) {
              final pos = _normalize(j.position);
              final pub = _normalize(j.publisherName);
              return pos.contains(needle) || pub.contains(needle);
            }).toList();
    });
  }

  /// تقليل عدد مرات التصفية أثناء الكتابة
  void _onSearchDebounced(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      _onSearchImmediate(q);
    });
  }

  void _clearSearch() {
    _searchCtrl.clear();
    _onSearchImmediate('');
    _focusNode.requestFocus();
  }

  String _formatDate(String iso) {
    if (iso.isEmpty) return '';
    final i = iso.indexOf('T');
    return i > 0 ? iso.substring(0, i) : iso;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: RefreshIndicator(
            onRefresh: _load,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  // الشريط العلوي
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // لاحقاً: فلاتر إضافية (مدينة/نوع عقد/دوام...)
                        },
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

                  // شريط البحث (مباشر ضمن نفس الصفحة)
                  TextField(
                    controller: _searchCtrl,
                    focusNode: _focusNode,
                    textInputAction: TextInputAction.search,
                    onChanged: _onSearchDebounced,
                    onSubmitted: _onSearchImmediate,
                    decoration: InputDecoration(
                      hintText: 'ابحث بالعنوان أو دار النشر...',
                      hintStyle: const TextStyle(fontSize: 12),
                      prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.primary),
                      suffixIcon: (_searchCtrl.text.isNotEmpty)
                          ? IconButton(
                              tooltip: 'مسح',
                              onPressed: _clearSearch,
                              icon: const Icon(Icons.close, size: 18, color: AppColors.primary),
                            )
                          : null,
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

                  // المحتوى
                  Expanded(
                    child: _loading
                        ? const Center(child: CircularProgressIndicator())
                        : _filtered.isEmpty
                            ? ListView(
                                children: [
                                  const Gap(40),
                                  const Icon(Icons.work_off, size: 56, color: AppColors.primary),
                                  const Gap(12),
                                  const Center(child: Text('لا توجد نتائج مطابقة')),
                                  const Gap(8),
                                  TextButton.icon(
                                    onPressed: _clearSearch,
                                    icon: const Icon(Icons.refresh),
                                    label: const Text('إعادة التعيين'),
                                  ),
                                ],
                              )
                            : ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: _filtered.length,
                                separatorBuilder: (_, __) => const Gap(12),
                                itemBuilder: (context, i) {
                                  final job = _filtered[i];
                                  return JobCard(
                                    title: job.position,
                                    type: job.publisherName.isEmpty ? 'غير مذكور' : job.publisherName,
                                    location: (job.publisherAddress?.isNotEmpty == true)
                                        ? job.publisherAddress!
                                        : 'غير مذكور',
                                    // ما في deadline بالـ API، نعرض createdAt بصيغة yyyy-MM-dd
                                    deadline: _formatDate(job.createdAt),
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
      ),
    );
  }
}
