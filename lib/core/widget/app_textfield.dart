import 'package:dar_nashr/core/resources/color.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.labelText,
    this.myIcon,
    required this.hintText,
    this.traillingIcon,
    this.obscureText = false,
    this.controller,
    this.validator,
  }) : super(key: key);

  final String? labelText;
  final Widget? myIcon;
  final String hintText;
  final bool obscureText;
  final Widget? traillingIcon;

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      height: 70, // كبرنا شوي لرسالة الخطأ لو ظهرت
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: controller,
          validator: validator,
          textAlign: TextAlign.right,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.textSecondaryC,
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textSecondaryC),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: traillingIcon,
            prefixIcon: myIcon,
            labelText: labelText ?? null,
            labelStyle: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
