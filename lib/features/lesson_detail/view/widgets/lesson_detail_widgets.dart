import 'package:e_learning_app/common/models/lesson_entities.dart';
import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/utils/app_constants.dart';
import 'package:e_learning_app/common/utils/image_resources.dart';
import 'package:e_learning_app/common/widgets/app_box_decoration.dart';
import 'package:e_learning_app/common/widgets/image_widgets.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:e_learning_app/features/lesson_detail/controller/lesson_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonVideos extends StatelessWidget {
  final List<LessonVideoItem> lessonData;
  final WidgetRef ref;
  final Function syncVideoIndex;

  const LessonVideos({super.key, required this.lessonData, required this.ref, required this.syncVideoIndex});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: lessonData.length,
        itemBuilder: (_, index) {
          return Container(
            margin: EdgeInsets.only(top: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            width: 325.w,
            height: 80.h,
            decoration: appBoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                radius: 10,
                sR: 2,
                bR: 3),
            child: InkWell(
              onTap: () {
                syncVideoIndex(index);
                var vidUrl = lessonData[index].url;
                ref.read(lessonDataControllerProvider.notifier).playNextVideo(vidUrl!);
              },
              child: Row(
                children: [
                  Container(
                    child: AppBoxDecorationImage(
                      imagePath:
                      "${AppConstants.IMAGE_UPLOADS_PATH}${lessonData[index].thumbnail}",
                      width: 50.w,
                      height: 50.h,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextNormal(
                          fontSize: 13,
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                          text: lessonData[index].name,
                        ),
                        // TextNormal(
                        //   fontSize: 11,
                        //   color: AppColors.primaryThirdElementText,
                        //   fontWeight: FontWeight.bold,
                        //   text: lessonData[index].description!,
                        //   maxLines: 1,
                        //   textOverflow: TextOverflow.clip,
                        // )
                      ],
                    ),
                  ),
                  AppImage(
                    imagePath: ImageResources.arrowRightIcon,
                    width: 25.w,
                    height: 25.h,
                  )
                ],
              ),
            ),
          );
        });
  }
}
