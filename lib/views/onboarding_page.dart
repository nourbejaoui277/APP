import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to AURA!",
      "subtitle": "Your one-stop shop for Tunisian fashion and lifestyle.",
      "image": "assets/images/welcome.png",
    },
    {
      "title": "Proudly Tunisian 🇹🇳",
      "subtitle": "AURA brings you 619 authentic Tunisian brands!",
      "image": "assets/images/tunisian_brands.png",
    },
    // to add pages
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: onboardingData.length,
        itemBuilder: (context, index) => OnboardingContent(
          title: onboardingData[index]["title"]!,
          subtitle: onboardingData[index]["subtitle"]!,
          image: onboardingData[index]["image"]!,
        ),
      ),
      bottomSheet: _currentPage == onboardingData.length - 1
          ? TextButton(
              onPressed: () async {
                // Save onboarding completion status
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('hasSeenOnboarding', true);

                // Navigate to login page
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Let’s Go!", style: TextStyle(fontSize: 18)),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () =>
                      _controller.jumpToPage(onboardingData.length - 1),
                  child: const Text("Skip"),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: onboardingData.length,
                ),
                TextButton(
                  onPressed: () => _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  ),
                  child: const Text("Next"),
                ),
              ],
            ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title, subtitle, image;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300),
        const SizedBox(height: 20),
        Text(title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(subtitle, textAlign: TextAlign.center),
      ],
    );
  }
}
