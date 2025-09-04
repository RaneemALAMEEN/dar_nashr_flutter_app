import 'package:dar_nashr/core/widget/app_button.dart';
import 'package:dar_nashr/core/widget/app_textfield.dart';
import 'package:flutter/material.dart';

import 'package:dar_nashr/core/resources/color.dart';
import 'package:gap/gap.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(left: 8, top: 25, right: 5),
                  child: FloatingActionButton(
                    backgroundColor: AppColors.background,
                    onPressed: () {},
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Gap(50),
              Text(
                'إعادة تعيين كلمة المرور',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                ),
                //  textAlign: TextAlign.center,
              ),
              Gap(50),
              AppTextField(
                myIcon: Icon(Icons.lock),
                hintText: 'كلمة المرور الجديدة',
                labelText: '',
              ),
              Gap(8),
              const AppTextField(
                myIcon: Icon(Icons.lock),
                labelText: '',
                hintText: 'تأكيد كلمة المرور الجديدة',
                obscureText: true,
              ),
              Gap(50),
              AppButton(
                text: 'حفظ كلمة المرور',
                onTap: () {
                  // منطق حفظ كلمة المرور
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
