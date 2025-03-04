import 'package:e_learning_app/common/models/course_entities.dart';
import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/utils/image_resources.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration appBoxDecoration({
  Color color = AppColors.primaryElement,
  double radius = 15,
  double sR = 1,
  double bR = 2,
  BoxBorder? boxBorder,
}) {
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
          topLeft: Radius.circular(20.h), topRight: Radius.circular(20.h)),
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
      border: Border.all(color: borderColor));
}

class AppBoxDecorationImage extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;
  final BoxFit boxFit;
  final CourseItem? courseItem;
  final Function()? func;

  const AppBoxDecorationImage(
      {super.key,
      this.width = 40,
      this.height = 40,
      this.imagePath = ImageResources.defaultIcon,
      this.boxFit = BoxFit.fitHeight,
      this.courseItem,
      this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        func;
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: boxFit, image: NetworkImage(imagePath), opacity: 0.9),
            borderRadius: BorderRadius.circular(20.w)),
        child: courseItem == null
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w),
                    child: FadeText(
                      text: courseItem!.name!,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.w, bottom: 20.h),
                    child: FadeText(
                      text: "${courseItem!.lesson_num!.toString()} Lessons",
                      color: AppColors.primaryThirdElementText,
                    ),
                  )
                ],
              ),

        // child: ClipRRect(
        //     borderRadius: BorderRadius.circular(20.w),
        //   child: Image.network(imagePath, fit: boxFit, height: height, width: width)
        // )
      ),
    );
  }
}
