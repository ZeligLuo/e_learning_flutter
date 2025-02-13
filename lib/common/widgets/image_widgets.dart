import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/utils/image_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appImage(
    {String imagePath = ImageResources.defaultIcon,
    double width = 16,
    double height = 16}) {
  return Image.asset(
    imagePath.isEmpty ? ImageResources.defaultIcon : imagePath,
    width: width.w,
    height: height.h,
  );
}

Widget appImageWithColor(
    {String imagePath = ImageResources.defaultIcon,
    double width = 16,
    double height = 16,
    Color color = AppColors.primaryElement}) {
  return Image.asset(
    imagePath.isEmpty ? ImageResources.defaultIcon : imagePath,
    width: width.w,
    height: height.h,
    color: color,
  );
}
