import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dar_nashr/pages/splash_page.dart';
import 'package:dar_nashr/pages/onboarding/on_boarding_page.dart';
import 'package:dar_nashr/pages/Auth/login_page.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    // final prefs = await SharedPreferences.getInstance();
    // final hasSeen = prefs.getBool('onboardingSeen') ?? false;

    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoardingPage(),

          // builder: (_) => hasSeen ?  LoginPage() : OnBoardingPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashPage();
  }
}
