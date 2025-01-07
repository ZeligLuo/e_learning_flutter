import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget text24Normal(
    {required String text, Color color = AppColors.primaryText}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style:
        TextStyle(color: color, fontSize: 24.sp, fontWeight: FontWeight.normal),
  );
}

Widget text16Normal(
    {required String text,
    Color color = AppColors.primarySecondaryElementText}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style:
        TextStyle(color: color, fontSize: 16.sp, fontWeight: FontWeight.normal),
  );
}

Widget text14Normal(
    {required String text, Color color = AppColors.primaryThirdElementText}) {
  return Text(
    text,
    textAlign: TextAlign.start,
    style:
        TextStyle(color: color, fontSize: 14.sp, fontWeight: FontWeight.normal),
  );
}

Widget textUnderline({String text = ''}) {
  return GestureDetector(
    onTap: () {},
    child: Text(text,
        style: TextStyle(
            color: AppColors.primaryText,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.primaryText,
            fontWeight: FontWeight.normal,
            fontSize: 12.sp)),
  );
}
