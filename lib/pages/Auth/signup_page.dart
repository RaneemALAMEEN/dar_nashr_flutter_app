import 'package:dar_nashr/core/resources/color.dart';
import 'package:dar_nashr/core/widget/app_button.dart';
import 'package:dar_nashr/core/widget/app_textfield.dart';
import 'package:dar_nashr/core/widget/row_login_register.dart';
import 'package:dar_nashr/pages/Auth/verification_page.dart';
import 'package:dar_nashr/services/otp_service.dart';
import 'package:dar_nashr/services/signup_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isObscure = true;
  bool isConfirmObscure = true;
  String? userType = 'reader';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/letters.png'),
                    alignment: Alignment.topLeft,
                  ),
                ),
                padding: EdgeInsets.only(bottom: 40, right: 25),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'إنشاء حساب',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 'reader',
                              groupValue: userType,
                              activeColor: AppColors.primary,
                              onChanged: (value) {
                                setState(() {
                                  userType = value!;
                                });
                              },
                            ),
                            Text('قارئ',
                                style: TextStyle(color: AppColors.primary)),
                          ],
                        ),
                        SizedBox(width: 20),
                        Row(
                          children: [
                            Radio(
                              value: 'writer',
                              groupValue: userType,
                              activeColor: AppColors.primary,
                              onChanged: (value) {
                                setState(() {
                                  userType = value!;
                                });
                              },
                            ),
                            Text('كاتب',
                                style: TextStyle(color: AppColors.primary)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Gap(15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AppTextField(
                  controller: nameController,
                  myIcon: Icon(Icons.person),
                  hintText: "الاسم الكامل",
                  labelText: '',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'الرجاء إدخال الاسم الكامل';
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AppTextField(
                  controller: phoneController,
                  myIcon: Icon(Icons.phone),
                  hintText: "رقم الهاتف",
                  labelText: '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AppTextField(
                  controller: emailController,
                  myIcon: Icon(Icons.email),
                  hintText: "البريد الإلكتروني",
                  labelText: '',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'الرجاء إدخال البريد الإلكتروني';
                    // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}\$')
                    //     .hasMatch(value)) {
                    //   return 'الرجاء إدخال بريد إلكتروني صالح';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                        .hasMatch(value)) {
                      return 'الرجاء إدخال بريد إلكتروني صالح';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AppTextField(
                  controller: passwordController,
                  obscureText: isObscure,
                  myIcon: Icon(Icons.lock),
                  hintText: "كلمة المرور",
                  labelText: '',
                  traillingIcon: IconButton(
                    icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'الرجاء إدخال كلمة المرور';
                    if (value.length < 6)
                      return 'يجب أن تكون 6 محارف على الأقل';
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AppTextField(
                  controller: confirmPasswordController,
                  obscureText: isConfirmObscure,
                  myIcon: Icon(Icons.lock_outline),
                  hintText: "تأكيد كلمة المرور",
                  labelText: '',
                  traillingIcon: IconButton(
                    icon: Icon(
                      isConfirmObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isConfirmObscure = !isConfirmObscure;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value != passwordController.text)
                      return 'كلمتا المرور غير متطابقتين';
                    return null;
                  },
                ),
              ),

              /// زر التسجيل
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
                child: AppButton(
                    text: "إنشاء حساب",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final success = await RegisterService.register(
                          username: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          role: userType!,
                        );

                        if (success) {

                          final otpSent =
                              await OtpService.sendOtp(emailController.text);
                          if (otpSent) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'تم إرسال رمز التحقق إلى بريدك الإلكتروني'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            await Future.delayed(const Duration(seconds: 2));

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerificationPage(
                                        email: emailController.text,
                                      )),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('فشل في إرسال رمز التحقق'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else {
                       
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('فشل في إنشاء الحساب')),
                          );
                        }
                      }
                    }

                    
                    ),
              ),

              SignIn(
                  text: "لديك حساب؟ ",
                  textButton: "تسجيل دخول",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }),

              Gap(20),

              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 105,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/OBJECTS.png'),
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
