import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextNormal extends StatelessWidget {
  final String? text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign textAlign;

  const TextNormal(
      {super.key,
      this.text = "",
      this.color = AppColors.primaryThirdElementText,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal, this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
          color: color, fontSize: fontSize.sp, fontWeight: fontWeight),
    );
  }
}

class FadeText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const FadeText(
      {super.key,
        this.text = "",
        this.color = AppColors.primaryElementText,
        this.fontSize = 10});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: false,
      maxLines: 1,
      textAlign: TextAlign.start,
      overflow: TextOverflow.fade,
      style: TextStyle(
          color: color, fontSize: fontSize.sp, fontWeight: FontWeight.bold),
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
