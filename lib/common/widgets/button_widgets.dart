import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/widgets/app_box_decoration.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Widget appButton(
//     {String buttonName = '',
//     double width = 325,
//     double height = 50,
//     bool isLogin = true,
//     BuildContext? context,
//     void Function()? func}) {
//   return GestureDetector(
//     onTap: func,
//     child: Container(
//       width: width.w,
//       height: height.h,
//       decoration: appBoxDecoration(
//           color:
//               isLogin ? AppColors.primaryElement : AppColors.primaryBackground,
//           boxBorder: Border.all(color: AppColors.primaryFourthElementText)),
//       child: Center(
//           child: TextNormal(
//         text: buttonName,
//         color: isLogin ? AppColors.primaryBackground : AppColors.primaryText,
//         fontSize: 16,
//       )),
//     ),
//   );
// }

class AppButton extends StatelessWidget {
  final String buttonName;
  final double width;
  final double height;
  final bool isLogin;
  final BuildContext? context;
  final void Function()? func;

  const AppButton(
      {super.key,
      this.buttonName = '',
      this.width = 325,
      this.height = 50,
      this.isLogin = true,
      this.context,
      this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: appBoxDecoration(
            color: isLogin
                ? AppColors.primaryElement
                : AppColors.primaryBackground,
            boxBorder: Border.all(color: AppColors.primaryFourthElementText)),
        child: Center(
            child: TextNormal(
          text: buttonName,
          color: isLogin ? AppColors.primaryBackground : AppColors.primaryText,
          fontSize: 16,
        )),
      ),
    );
  }
}
