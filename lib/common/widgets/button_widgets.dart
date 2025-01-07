import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/widgets/app_shadow.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appButton(
    {String buttonName = '',
    double width = 325,
    double height = 50,
    bool isLogin = true,
    BuildContext? context,
    void Function()? func}) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: width.w,
      height: height.h,
      decoration: appBoxShadow(
          color:
              isLogin ? AppColors.primaryElement : AppColors.primaryBackground,
          border: Border.all(color: AppColors.primaryFourthElementText)),
      child: Center(
          child: text16Normal(
              text: buttonName,
              color: isLogin
                  ? AppColors.primaryBackground
                  : AppColors.primaryText)),
    ),
  );
}
