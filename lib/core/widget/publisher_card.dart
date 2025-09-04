// lib/core/widget/publisher_card.dart
import 'package:flutter/material.dart';
import 'package:dar_nashr/main.dart';

class PublisherCard extends StatelessWidget {
  final String name;
  final String? logoUrl;      // ← رابط الصورة (قد يكون نسبي)
  final VoidCallback? onTap;

  const PublisherCard({
    super.key,
    required this.name,
    this.logoUrl,
    this.onTap,
  });

  String _fullUrl(String? path) {
    if (path == null || path.isEmpty || path.toLowerCase() == 'string') return '';
    if (path.startsWith('http')) return path;
    final normalized = path.replaceAll('\\', '/').replaceFirst(RegExp(r'^/+'), '');
    final base = url.endsWith('/') ? url : '$url/';
    return '$base$normalized';
  }

  @override
  Widget build(BuildContext context) {
    final resolved = _fullUrl(logoUrl);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: resolved.isNotEmpty
                    ? Image.network(
                        resolved,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'images/دار الفكر لوغو.png', // بديل افتراضي
                          fit: BoxFit.contain,
                        ),
                      )
                    : Image.asset(
                        'images/دار الفكر لوغو.png',
                        fit: BoxFit.contain,
                      ),
              ),
              const SizedBox(height: 6),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff1D2A45),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
