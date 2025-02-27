import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextNormal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;

  const TextNormal(
      {super.key,
      this.text = "",
      this.color = AppColors.primaryThirdElementText,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
          color: color, fontSize: fontSize.sp, fontWeight: fontWeight),
    );
  }
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
