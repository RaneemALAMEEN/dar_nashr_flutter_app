

import 'package:dar_nashr/core/resources/color.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({
    Key? key,
    required this.text,
    required this.textButton,
    required this.onTap, 
  }) : super(key: key);

  final String text;
  final String textButton;
  final VoidCallback onTap; 

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onTap, 
          child: Text(
            textButton,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.onPrimary,
              fontSize: 16,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
