import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/widgets/app_shadow.dart';
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
        text14Normal(text: text),
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
              SizedBox(
                width: 280.w,
                height: 50.h,
                child: TextField(
                  controller: controller,
                  onChanged: (value) => func!(value),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                        color: AppColors.primaryFourthElementText),
                    border: _outlineBorder(),
                    enabledBorder: _outlineBorder(),
                    focusedBorder: _outlineBorder(),
                    disabledBorder: _outlineBorder(),
                  ),
                  maxLines: 1,
                  autocorrect: false,
                  obscureText: obscureText,
                ),
              )
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
