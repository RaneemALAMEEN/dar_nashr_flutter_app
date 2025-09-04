// lib/core/sections/publishers_section.dart (أو نفس ملفك)
import 'package:flutter/material.dart';
import 'package:dar_nashr/core/widget/publisher_card.dart';
import 'package:dar_nashr/core/widget/section_header_widget.dart';
import 'package:dar_nashr/models/publisher_model.dart';
import 'package:dar_nashr/services/publisher_service.dart';

class PublishersSection extends StatefulWidget {
  const PublishersSection({super.key});

  @override
  State<PublishersSection> createState() => _PublishersSectionState();
}

class _PublishersSectionState extends State<PublishersSection> {
  final _service = PublisherService();
  List<Publisher> _publishers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPublishers();
  }

  Future<void> _loadPublishers() async {
    try {
      final data = await _service.getPublishers();
      setState(() {
        _publishers = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      // بإمكانك تعرض SnackBar هنا لو حابب
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'دور النشر',
          onViewAll: () {
            // TODO: افتح صفحة كل دور النشر إن حبيت
          },
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _publishers.isEmpty
                  ? const Center(child: Text('لا توجد دور نشر'))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _publishers.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final p = _publishers[index];
                        return PublisherCard(
                          name: p.name,
                          logoUrl: p.logoImage,     // قد تكون relative
                          onTap: () {
                            // TODO: افتح صفحة تفاصيل الناشر إذا عندك
                            // Navigator.push(...);
                          },
                        );
                      },
                    ),
        ),
      ],
    );
  }
}
