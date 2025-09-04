import 'package:dar_nashr/core/widget/app_button.dart';
import 'package:dar_nashr/core/widget/app_textfield.dart';
import 'package:dar_nashr/pages/Auth/login_page.dart';
import 'package:dar_nashr/pages/Auth/verification_page.dart';
import 'package:flutter/material.dart';

import 'package:dar_nashr/core/resources/color.dart';
import 'package:gap/gap.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               

                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8, top: 25, right: 5),
                    child: FloatingActionButton.small(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                Gap(50),
                Text(
                  'قم بإدخال البريد الإلكتروني لإعادة تعيين كلمة المرور',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                  ),
                  //textAlign: TextAlign.center,
                ),
                Gap(50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: AppTextField(
                    myIcon: Icon(Icons.email),
                    hintText: "البريد الإلكتروني",
                    labelText: '',
                  ),
                ),
                Gap(60),
                AppButton(
                  text: 'إرسال رمز التحقق',
                  onTap: () {
                  //  Navigator.pushReplacement(
                  //         context,
                  //      //   MaterialPageRoute(builder: (context) => VerificationPage()),
                  //       );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
