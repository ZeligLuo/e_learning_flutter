import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration appBoxDecoration(
    {Color color = AppColors.primaryElement,
    double radius = 15,
    double sR = 1,
    double bR = 2,
    BoxBorder? boxBorder}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: boxBorder,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: sR,
            blurRadius: bR,
            offset: const Offset(0, 1))
      ]);
}

BoxDecoration appBoxDecorationWithRadius(
    {Color color = AppColors.primaryElement,
      double radius = 15,
      double sR = 1,
      double bR = 2,
      BoxBorder? border}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.h),
        topRight: Radius.circular(20.h)
      ),
      border: border,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: sR,
            blurRadius: bR,
            offset: const Offset(0, 1))
      ]);
}

BoxDecoration appBoxDecorationTextField(
    {Color color = AppColors.primaryBackground,
      double radius = 15,
      Color borderColor = AppColors.primaryFourthElementText}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor)
      );
}