import 'package:flutter/material.dart';
import 'package:dar_nashr/models/publisher_model.dart';
import 'package:dar_nashr/core/resources/color.dart';
import 'package:dar_nashr/main.dart';
import 'package:dar_nashr/services/publisher_service.dart';
import 'package:dar_nashr/models/book_model.dart';
import 'package:dar_nashr/core/widget/book_card.dart';

class PublisherDetailsPage extends StatefulWidget {
  final Publisher publisher;
  const PublisherDetailsPage({super.key, required this.publisher});

  @override
  State<PublisherDetailsPage> createState() => _PublisherDetailsPageState();
}

class _PublisherDetailsPageState extends State<PublisherDetailsPage> {
  final _service = PublisherService();
  List<Book> _books = [];
  bool _loadingBooks = true;

  String _fullUrl(String? path) {
    if (path == null || path.isEmpty || path.toLowerCase() == 'string') return '';
    if (path.startsWith('http')) return path;
    final normalized = path.replaceAll('\\', '/').replaceFirst(RegExp(r'^/+'), '');
    final base = url.endsWith('/') ? url : '$url/';
    return '$base$normalized';
  }

  String _dateOnly(String iso) {
    final i = iso.indexOf('T');
    return i > 0 ? iso.substring(0, i) : iso;
  }

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    try {
      final res = await _service.getBooksByPublisher(widget.publisher.id);
      if (!mounted) return;
      setState(() {
        _books = res;
        _loadingBooks = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loadingBooks = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذّر تحميل كتب الدار'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.publisher;
    final logo = _fullUrl(p.logoImage);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightGray,
        appBar: AppBar(
          title: const Text('تفاصيل دار النشر'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              // Header بتدرّج + شعار
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [AppColors.primary, Color(0xFF25365A)],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -36,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: AppColors.textSecondaryC,
                        backgroundImage: logo.isEmpty ? null : NetworkImage(logo),
                        child: logo.isEmpty
                            ? const Icon(Icons.apartment, color: AppColors.primary, size: 36)
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36 + 12),

              // بطاقة الاسم + الحالة + تاريخ الإنشاء
              _SectionCard(
                bottomSpacing: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      p.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      alignment: WrapAlignment.center,
                      children: [
                        Chip(
                          label: Text(p.isActive ? 'نشِطة' : 'غير نشِطة',
                              style: const TextStyle(color: Colors.white)),
                          backgroundColor: p.isActive ? Colors.green[700] : Colors.grey,
                        ),
                        Chip(
                          label: Text(p.isVerified ? 'موثّقة' : 'غير موثّقة',
                              style: const TextStyle(color: Colors.white)),
                          backgroundColor: p.isVerified ? AppColors.onPrimary : Colors.blueGrey,
                        ),
                        Chip(
                          label: Text('تاريخ الإنشاء: ${_dateOnly(p.createdAt)}',
                              style: const TextStyle(color: Colors.white)),
                          backgroundColor: AppColors.secondary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // معلومات التواصل
              _SectionCard(
                title: 'معلومات التواصل',
                child: Column(
                  children: [
                    _InfoRow(icon: Icons.email, label: 'البريد', value: p.email),
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.phone,
                      label: 'رقم التواصل',
                      value: p.contactInfo?.isNotEmpty == true ? p.contactInfo! : '—',
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'العنوان',
                      value: p.address?.isNotEmpty == true ? p.address! : '—',
                    ),
                  ],
                ),
              ),

              // ✅ قسم كتب الدار
              _SectionCard(
                title: 'كتب هذه الدار',
                child: _loadingBooks
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : (_books.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Text('لا توجد كتب منشورة لهذه الدار',
                                style: TextStyle(color: AppColors.textPrimary)),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: _books.length,
                            itemBuilder: (context, i) {
                              return BookCard(book: _books[i]);
                            },
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final double bottomSpacing;
  const _SectionCard({this.title, required this.child, this.bottomSpacing = 8});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, bottomSpacing),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                const Icon(Icons.menu_book, size: 18, color: AppColors.onPrimary),
                const SizedBox(width: 6),
                Text(
                  title!,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.onPrimary),
        const SizedBox(width: 8),
        Text('$label:',
            style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: AppColors.textPrimary),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
