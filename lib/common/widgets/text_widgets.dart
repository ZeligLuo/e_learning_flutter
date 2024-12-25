import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:flutter/material.dart';

Widget text24Normal({required String text, Color color=AppColors.primaryText}) {


  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.normal),
  );
}

Widget text16Normal({required String text, Color color=AppColors.primarySecondaryElementText}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.normal),
  );
}