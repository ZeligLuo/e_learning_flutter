import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

AppBar buildAppbar({String title=''}) {
  return AppBar(
    title: text16Normal(text: title, color: AppColors.primaryText),
    bottom:
    /* put space under appbar for widget */
    PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          height: 1,
        )),
  );
}