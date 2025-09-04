
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Color(0xff1D2A45),
          ),
        ),
        TextButton(
          onPressed: onViewAll,
          child: const Text(
            'عرض الكل',
            style: TextStyle(color: Color(0xff731F28)),
          ),
        ),
      ],
    );
  }
}