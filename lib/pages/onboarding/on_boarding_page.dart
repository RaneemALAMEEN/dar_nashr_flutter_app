import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dar_nashr/pages/Auth/login_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "images/OnBoarding.png",
      "title": "تنقل بين دور النشر ضمن تطبيق واحد!",
      "subtitle": "اقرأ ما تحب من أحدث الإصدارات إلى أندر الكتب الكلاسيكية",
    },
    {
      "image": "images/onboarding2.png",
      "title": "شارك كتاباتك مع جمهور واسع",
      "subtitle": "وتواصل مع دور نشر تبحث عن أقلام واعدة مثلك",
    },
    {
      "image": "images/onboarding3.png",
      "title": "اكتشف فرص عمل أدبية",
      "subtitle": "وابدأ مسيرتك ككاتب، مدقق، أو محرر ضمن دور النشر",
    },
  ];

  void _nextPage() async {
    if (currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboardingSeen', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  Color getContainerColor(int index) {
    if (index == 0) {
      return const Color.fromARGB(80, 198, 165, 100);
    } else if (index == 1) {
      return const Color.fromARGB(60, 198, 165, 100);
    } else {
      return const Color.fromARGB(100, 198, 165, 100);
    }
  }

  double getGradientOpacity(int index) {
    if (index == 0) return 0.2;
    if (index == 1) return 0.15;
    return 0.25;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingData.length,
        onPageChanged: (index) {
          setState(() => currentPage = index);
        },
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(onboardingData[index]["image"]!),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(getGradientOpacity(index)),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: index == 0 ? 250 : 200,
                      maxHeight: index == 0 ? 350 : 320,
                    ),
                    decoration: BoxDecoration(
                      color: getContainerColor(index),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 286,
                          child: Text(
                            onboardingData[index]["title"]!,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'ReemKufi',
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 275,
                          child: Text(
                            onboardingData[index]["subtitle"]!,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                      (i) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: currentPage == i ? Colors.white : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: _nextPage,
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
