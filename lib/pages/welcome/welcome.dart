import 'package:e_learning_app/pages/welcome/widgets.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  Welcome({super.key});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            children: [
              appOnBoardingPage(_controller,
                  imagePath: "assets/images/reading.png",
                  title: "First see learning",
                  subtitle:
                      "Forget about the paper, now learning all in one place.",
                  index: 1),
              appOnBoardingPage(_controller,
                  imagePath: "assets/images/man.png",
                  title: "Connect with everyone",
                  subtitle:
                      "Always keep in touch with your tutor and friends. Let's get connected.",
                  index: 2),
              appOnBoardingPage(_controller,
                  imagePath: "assets/images/boy.png",
                  title: "Always Fascinated Learning",
                  subtitle:
                      "Anywhere, anytime. The time is at your discretion. So study wherever you can.",
                  index: 3)
            ],
          ),
          const Positioned(bottom: 100, left: 20, child: Text('wg 1')),
          const Positioned(bottom: 100, left: 200, child: Text('wg 2')),
        ],
      ),
    );
  }
}
