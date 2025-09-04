
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:dar_nashr/core/resources/color.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "ابحث عن كاتب، كتاب أو دار نشر...",
              hintStyle: const TextStyle(fontSize: 12),
              prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        const Gap(8),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list_alt, color: AppColors.primary),
        ),
      ],
    );
  }
}
