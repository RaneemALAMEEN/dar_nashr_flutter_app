import 'package:dar_nashr/core/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/imagesh 1.png"),
            SizedBox(
              height: 30,
            ),
            SvgPicture.asset("images/فِكْر.svg")
          ],
        ),
      ),
    );
  }
}
