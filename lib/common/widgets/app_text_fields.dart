import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/widgets/app_box_decoration.dart';
import 'package:e_learning_app/common/widgets/image_widgets.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appTextField(
    {TextEditingController? controller,
    String text = '',
    String iconName = '',
    String hintText = 'Input something',
    bool obscureText = false,
    void Function(String value)? func}) {
  return Container(
    padding: EdgeInsets.only(left: 25.w, right: 25.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextNormal(text: text),
        SizedBox(height: 5.h),
        Container(
          width: 325.w,
          height: 50.h,
          decoration: appBoxDecorationTextField(),
          child: Row(
            children: [
              // text field icon
              Container(
                margin: EdgeInsets.only(left: 17.w),
                child: appImage(imagePath: iconName),
              ),
              // text field
              appTextFieldOnly(
                  controller: controller,
                  hintText: hintText,
                  func: func,
                  obscureText: obscureText)
            ],
          ),
        )
      ],
    ),
  );
}

OutlineInputBorder _outlineBorder() {
  return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent));
}

Widget appTextFieldOnly(
    {TextEditingController? controller,
    String hintText = 'Input something',
    double width = 280,
    double height = 50,
    void Function(String value)? func,
    bool obscureText = false}) {
  return SizedBox(
    width: width.w,
    height: height.h,
    child: TextField(
      controller: controller,
      onChanged: (value) => func!(value),
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 5.h, left: 10.w),
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.primaryFourthElementText),
        border: _outlineBorder(),
        enabledBorder: _outlineBorder(),
        focusedBorder: _outlineBorder(),
        disabledBorder: _outlineBorder(),
      ),
      maxLines: 1,
      autocorrect: false,
      obscureText: obscureText,
    ),
  );
}
