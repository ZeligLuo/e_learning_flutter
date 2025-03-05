import 'package:e_learning_app/common/models/course_entities.dart';
import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/utils/app_constants.dart';
import 'package:e_learning_app/common/utils/image_resources.dart';
import 'package:e_learning_app/common/widgets/app_box_decoration.dart';
import 'package:e_learning_app/common/widgets/button_widgets.dart';
import 'package:e_learning_app/common/widgets/image_widgets.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetailThumbnail extends StatelessWidget {
  final CourseItem courseItem;
  const CourseDetailThumbnail({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return AppBoxDecorationImage(
      imagePath: "${AppConstants.IMAGE_UPLOADS_PATH}${courseItem.thumbnail}",
      width: 325.w,
      height: 200.h,
      boxFit: BoxFit.fitWidth,
    );
  }
}

class CourseDetailIconText extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailIconText({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      width: 325.w,
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              decoration: appBoxDecoration(radius: 8),
              child: const TextNormal(
                fontSize: 10,
                text: "Author Page",
                color: AppColors.primaryElementText,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.w),
            child: Row(children: [
              const AppImage(imagePath: ImageResources.peopleIcon),
              SizedBox(width: 3.w),
              TextNormal(
                  fontSize: 11,
                  text: courseItem.follow == null
                      ? "0"
                      : courseItem.follow.toString(),
                  color: AppColors.primaryThirdElementText)
            ]),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.w),
            child: Row(children: [
              const AppImage(imagePath: ImageResources.starIcon),
              SizedBox(width: 3.w),
              TextNormal(
                  fontSize: 11,
                  text: courseItem.score == null
                      ? "0"
                      : courseItem.score.toString(),
                  color: AppColors.primaryThirdElementText)
            ]),
          )
        ],
      ),
    );
  }
}

class CourseDetailDescription extends StatelessWidget {
  final CourseItem courseItem;
  const CourseDetailDescription({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextNormal(
            fontSize: 16,
            text: courseItem.name ?? "No name found!",
            color: AppColors.primaryText,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
          ),
          TextNormal(
              fontSize: 11,
              text: courseItem.description ?? "No description found!",
              color: AppColors.primarySecondaryElementText,
              textAlign: TextAlign.justify)
        ],
      ),
    );
  }
}

class CourseDetailBuyButton extends StatelessWidget {
  const CourseDetailBuyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15.h),
        child: const AppButton(buttonName: "Go Buy"));
  }
}

class CourseDetailIncludes extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailIncludes({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextNormal(
              fontSize: 14,
              text: "Course includes",
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.h),
            CourseInfo(
              imagePath: ImageResources.videoDetailIcon,
              length: courseItem.video_len.toString(),
              infoText: "hours video",
            ),
            SizedBox(height: 15.h),
            CourseInfo(
              imagePath: ImageResources.fileIcon,
              length: courseItem.lesson_num.toString(),
              infoText: "lessons",
            ),
            SizedBox(height: 15.h),
            CourseInfo(
              imagePath: ImageResources.downloadIcon,
              length: courseItem.down_num.toString(),
              infoText: "downloads",
            )
          ],
        ));
  }
}

class CourseInfo extends StatelessWidget {
  final String imagePath;
  final String? length;
  final String? infoText;

  const CourseInfo(
      {super.key,
      required this.imagePath,
      this.length,
      this.infoText = "number"});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // margin: EdgeInsets.only(bottom: 15.h),
          alignment: Alignment.center,
          child: AppImage(imagePath: imagePath, width: 30, height: 30),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w),
          child: TextNormal(
            fontSize: 11,
            text: length == null ? "0 $infoText" : "$length $infoText",
            color: AppColors.primarySecondaryElementText,
          ),
        )
      ],
    );
  }
}
