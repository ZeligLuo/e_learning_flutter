import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/utils/app_constants.dart';
import 'package:e_learning_app/common/widgets/app_box_decoration.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:e_learning_app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppOnBoardingPage extends StatelessWidget {
  final PageController controller;
  final String imagePath;
  final String title;
  final String subtitle;
  final int index;
  final BuildContext context;

  const AppOnBoardingPage(
      {super.key,
      required this.controller,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.index,
      required this.context});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.fitWidth,
        ),
        Container(
            margin: const EdgeInsets.only(top: 15),
            child: TextNormal(text: title, color: AppColors.primarySecondaryElementText,fontSize: 24)),
        Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: TextNormal(text: subtitle, color: AppColors.primarySecondaryElementText, fontSize: 16),
        ),
        _nextButton(index, controller, context)
      ],
    );
  }
}

Widget _nextButton(int index, PageController controller, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (index < 3) {
        controller.animateToPage(index,
            duration: const Duration(microseconds: 500), curve: Curves.linear);
      } else {
        // remember if first time open app or not
        Global.storageService
            .setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_KEY, true);

        Navigator.pushNamed(
          context,
          '/signIn',
        );
      }
    },
    child: Container(
      width: 325,
      height: 50,
      margin: const EdgeInsets.only(top: 100, left: 25, right: 25),
      decoration: appBoxDecoration(),
      child: Center(
          child: TextNormal(
              text: index < 3 ? 'Next' : 'Get Started',
              color: AppColors.primaryElementText,
              fontSize: 16)),
    ),
  );
}
