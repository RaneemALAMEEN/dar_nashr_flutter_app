// lib/pages/publishers/publishers_page.dart
import 'package:dar_nashr/pages/publisher/publisher_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:dar_nashr/core/resources/color.dart';
import 'package:dar_nashr/models/publisher_model.dart';
import 'package:dar_nashr/services/publisher_service.dart';
import 'package:dar_nashr/main.dart';

class PublishersPage extends StatefulWidget {
  const PublishersPage({super.key});

  @override
  State<PublishersPage> createState() => _PublishersPageState();
}

class _PublishersPageState extends State<PublishersPage> {
  final _service = PublisherService();
  final _searchCtrl = TextEditingController();
  List<Publisher> _all = [];
  List<Publisher> _filtered = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final res = await _service.getPublishers();
      setState(() {
        _all = res;
        _filtered = res;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذّر تحميل دور النشر'), backgroundColor: Colors.red),
      );
    }
  }

  void _onSearch(String q) {
    final needle = q.trim().toLowerCase();
    setState(() {
      _filtered = needle.isEmpty
          ? _all
          : _all.where((p) {
              return p.name.toLowerCase().contains(needle) ||
                     p.email.toLowerCase().contains(needle);
            }).toList();
    });
  }

  String _fullUrl(String? path) {
    if (path == null || path.isEmpty || path.toLowerCase() == 'string') return '';
    if (path.startsWith('http')) return path;
    final normalized = path.replaceAll('\\', '/').replaceFirst(RegExp(r'^/+'), '');
    final base = url.endsWith('/') ? url : '$url/';
    return '$base$normalized';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,

        // ✅ AppBar نفس لون الشاشة + زر القائمة الجانبية
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          title: const Text('دور النشر',
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
          foregroundColor: AppColors.primary,
          leading: Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // يفتح الـ Drawer إن وجد
                final scaffold = Scaffold.maybeOf(ctx);
                if (scaffold?.hasDrawer == true) {
                  scaffold!.openDrawer();
                }
              },
              tooltip: 'القائمة',
            ),
          ),
          actions: const [
            // زر شكلي (فلترة/إعدادات) كما في صفحة فرص العمل
            Padding(
              padding: EdgeInsetsDirectional.only(end: 8.0),
              child: Icon(Icons.filter_list),
            ),
          ],
        ),

        body: SafeArea(
          child: Column(
            children: [
              // شريط البحث
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: _onSearch,
                  decoration: InputDecoration(
                    hintText: 'ابحث باسم دار النشر أو البريد...',
                    hintStyle: const TextStyle(fontSize: 12),
                    prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.primary),
                    filled: true,
                    fillColor: AppColors.textSecondaryC,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  ),
                ),
              ),

              // المحتوى
              Expanded(
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : _filtered.isEmpty
                        ? const Center(child: Text('لا توجد نتائج'))
                        : ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                            itemCount: _filtered.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, i) {
                              final p = _filtered[i];
                              final logo = _fullUrl(p.logoImage);
                              return _PublisherCard(
                                name: p.name,
                                email: p.email,
                                isActive: p.isActive,
                                isVerified: p.isVerified,
                                logoUrl: logo,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PublisherDetailsPage(publisher: p),
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
    );
  }
}

/// بطاقة جميلة لدار النشر
class _PublisherCard extends StatelessWidget {
  final String name;
  final String email;
  final bool isActive;
  final bool isVerified;
  final String logoUrl;
  final VoidCallback onTap;

  const _PublisherCard({
    required this.name,
    required this.email,
    required this.isActive,
    required this.isVerified,
    required this.logoUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusChip = Chip(
      label: Text(isActive ? 'نشِطة' : 'غير نشِطة', style: const TextStyle(color: Colors.white)),
      backgroundColor: isActive ? Colors.green[700] : Colors.grey,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    final verifiedChip = Chip(
      label: Text(isVerified ? 'موثّقة' : 'غير موثّقة', style: const TextStyle(color: Colors.white)),
      backgroundColor: isVerified ? AppColors.onPrimary : Colors.blueGrey,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // اللوغو
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.textSecondaryC,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                clipBehavior: Clip.antiAlias,
                child: logoUrl.isEmpty
                    ? const Icon(Icons.apartment, color: AppColors.primary)
                    : Image.network(
                        logoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.apartment, color: AppColors.primary),
                      ),
              ),
              const SizedBox(width: 12),

              // النصوص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.email_outlined, size: 16, color: AppColors.onPrimary),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: -6,
                      children: [statusChip, verifiedChip],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),
              // ✅ السهم صار للأمام (يناسب RTL)
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: AppColors.primary, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
