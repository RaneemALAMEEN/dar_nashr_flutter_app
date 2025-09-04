import 'package:dar_nashr/core/widget/app_button.dart';
import 'package:dar_nashr/pages/Auth/login_page.dart';
import 'package:dar_nashr/services/otp_service.dart';
import 'package:dar_nashr/services/verify_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:dar_nashr/core/resources/color.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  const VerificationPage({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String otpCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8, top: 25),
                    child: FloatingActionButton.small(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Icon(Icons.arrow_back,
                          color: AppColors.primary),
                    ),
                  ),
                ),
                const Gap(50),
                const Text(
                  'تم إرسال رمز التحقق إلى بريدك الإلكتروني',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                  ),
                ),
                const Gap(50),
                OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 40,
                  style: const TextStyle(fontSize: 20),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onChanged: (code) {
                    otpCode = code;
                  },
                  onCompleted: (pin) {
                    otpCode = pin;
                    print("OTP Completed: $otpCode");
                  },
                ),
                const Gap(60),
                AppButton(
                  text: 'تأكيد',
                  onTap: () async {
                    final success = await VerifyOtpService().verifyOtp(
                      email: widget.email,
                      otp: otpCode,
                    );

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم التحقق من الكود بنجاح'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      await Future.delayed(const Duration(seconds: 2));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(' رمز التحقق غير صحيح'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
                const Gap(30),
                TextButton(
                  onPressed: () async {
                    var emailController;
                    final otpSent =
                        await OtpService.sendOtp(emailController.text);
                    ;
                    if (otpSent) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم إرسال رمز التحقق مرة أخرى بنجاح'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('فشل في إرسال رمز التحقق، حاول مرة أخرى'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'إرسال رمز التحقق مرة أخرى؟',
                    style: TextStyle(
                      color: AppColors.onPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
