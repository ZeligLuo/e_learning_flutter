import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/utils/image_resources.dart';
import 'package:e_learning_app/common/widgets/app_box_decoration.dart';
import 'package:e_learning_app/common/widgets/app_text_fields.dart';
import 'package:e_learning_app/common/widgets/image_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget searchBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // search box
      Container(
        width: 280.w,
        height: 40.h,
        decoration: appBoxDecoration(
            color: AppColors.primaryBackground,
            boxBorder: Border.all(color: AppColors.primaryFourthElementText)),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 17.w),
              child: const AppImage(imagePath: ImageResources.searchIcon),
            ),
            SizedBox(
              width: 240.w,
              height: 40.h,
              child: appTextFieldOnly(width: 240, height: 40, hintText: "Search course"),
            )
          ],
        ),
      ),
      // search btn
      GestureDetector(
        onTap: () {

        },
        child: Container(
          padding: EdgeInsets.all(5.w),
          width: 40.w,
          height: 40.h,
          decoration: appBoxDecoration(
            boxBorder: Border.all(color: AppColors.primaryElement)
          ),
          child: const AppImage(imagePath: ImageResources.searchBtnIcon),
        ),
      )
    ],
  );
}
