import 'package:dar_nashr/core/resources/color.dart';
import 'package:flutter/material.dart';


class OnBoardingItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnBoardingItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondaryC,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
