import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_learning_app/pages/welcome/welcome_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'notifier/welcome_notifier.dart';

final indexProvider = StateProvider<int>((ref) => 0);

class Welcome extends ConsumerWidget {
  Welcome({super.key});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexDotProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: 30.h),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // 3 welcome pages
                PageView(
                  onPageChanged: (value) {
                    ref.read(indexDotProvider.notifier).changeIndex(value);
                  },
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  children: [
                    appOnBoardingPage(_controller,
                        imagePath: "assets/images/reading.png",
                        title: "First See Learning",
                        subtitle:
                            "Forget about the paper, now learning all in one place.",
                        index: 1,
                        context: context),
                    appOnBoardingPage(_controller,
                        imagePath: "assets/images/man.png",
                        title: "Connect With Everyone",
                        subtitle:
                            "Always keep in touch with your tutor and friends. Let's get connected.",
                        index: 2,
                        context: context),
                    appOnBoardingPage(_controller,
                        imagePath: "assets/images/boy.png",
                        title: "Always Fascinated Learning",
                        subtitle:
                            "Anywhere, anytime. The time is at your discretion. So study wherever you can.",
                        index: 3,
                        context: context)
                  ],
                ),
                Positioned(
                  bottom: 50,
                  child: DotsIndicator(
                    position: index,
                    dotsCount: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(24.0, 8.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.w))),
                  ),
                )
                // const Positioned(bottom: 100, left: 20, child: Text('wg 1')),
                // const Positioned(bottom: 100, left: 200, child: Text('wg 2')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
