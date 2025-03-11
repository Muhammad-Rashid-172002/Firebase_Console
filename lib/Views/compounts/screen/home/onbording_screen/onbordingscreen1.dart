import 'package:chatnow/Views/compounts/screen/auth_module/SignupScreen.dart';
import 'package:chatnow/Views/compounts/screen/auth_module/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      "image": "assets/animation/Animation - 1741712347103.json",
      "title": "Welcome to ChatNow",
      "description":
          "Find and Connect with people easily.\nStart meaningful conversations anytime,\nanywhere!",
    },
    {
      "image": "assets/animation/Animation - 1741712677857.json",
      "title": "Secure Messaging",
      "description": "Your chats are end-to-end encrypted for privacy.",
    },
    {
      "image": "assets/animation/Animation - 1741712291481 (1).json",
      "title": "AI-Powered Search",
      "description": "Find messages quickly using smart AI search.",
    },
  ];

  void _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("onboardingComplete", true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Signupscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 300),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          textAlign: TextAlign.end,
                          'Skip',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Lottie.asset(_pages[index]["image"]!),
                    SizedBox(height: 20),
                    Text(
                      _pages[index]["title"]!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _pages[index]["description"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 20 : 10,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      _currentIndex == index
                          ? Colors.teal
                          : Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          GestureDetector(
            onTap:
                _currentIndex == _pages.length - 1
                    ? _completeOnboarding
                    : () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
            child: Container(
              height: 50,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                _currentIndex == _pages.length - 1 ? "Get Started" : "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 40),
        ],
      ),
    );
  }
}
