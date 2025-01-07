import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/widgets/app_shadow.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appOnBoardingPage(PageController controller,
    {required String imagePath,
    required String title,
    required String subtitle,
    index = 0,
    required BuildContext context}) {
  return Column(
    children: [
      Image.asset(
        imagePath,
        fit: BoxFit.fitWidth,
      ),
      Container(
          margin: const EdgeInsets.only(top: 15),
          child: text24Normal(text: title)),
      Container(
        margin: EdgeInsets.only(top: 15.h),
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: text16Normal(text: subtitle),
      ),
      _nextButton(index, controller, context)
    ],
  );
}

Widget _nextButton(int index, PageController controller, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (index < 3) {
        controller.animateToPage(index,
            duration: const Duration(microseconds: 500), curve: Curves.linear);
      } else {
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
      decoration: appBoxShadow(),
      child: Center(
          child: text16Normal(
              text: index<3?'Next':'Get Started', color: AppColors.primaryElementText)),
    ),
  );
}
