import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/utils/app_constants.dart';
import 'package:e_learning_app/common/utils/image_resources.dart';
import 'package:e_learning_app/common/widgets/app_bar.dart';
import 'package:e_learning_app/common/widgets/app_box_decoration.dart';
import 'package:e_learning_app/common/widgets/image_widgets.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:e_learning_app/features/course_detail/controller/course_controller.dart';
import 'package:e_learning_app/features/course_detail/view/widgets/course_detail_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetail extends ConsumerStatefulWidget {
  const CourseDetail({super.key});

  @override
  ConsumerState<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends ConsumerState<CourseDetail> {
  late var args;

  @override
  void didChangeDependencies() {
    var id = ModalRoute.of(context)!.settings.arguments as Map;
    args = id["id"];

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var courseData =
        ref.watch(courseDetailControllerProvider(index: args.toInt()));
    var lessonData =
        ref.watch(courseLessonListControllerProvider(index: args.toInt()));

    return Scaffold(
      appBar: buildGlobalAppbar(title: "Course Detail"),
      body: Padding(
        padding: EdgeInsets.only(left: 25.w, right: 25.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              courseData.when(
                  data: (data) => data == null
                      ? const SizedBox()
                      : Column(
                          children: [
                            CourseDetailThumbnail(courseItem: data),
                            CourseDetailIconText(courseItem: data),
                            CourseDetailDescription(courseItem: data),
                            const CourseDetailBuyButton(),
                            CourseDetailIncludes(courseItem: data),
                          ],
                        ),
                  error: (error, traceStack) =>
                      const Text("Error loading course data"),
                  loading: () => SizedBox(
                      height: 600.h,
                      child: const Center(child: CircularProgressIndicator()))),
              lessonData.when(
                  data: (data) => data == null
                      ? const SizedBox()
                      : LessonInfo(lessonItem: data),
                  error: (error, traceStack) =>
                      const Text("Error loading lesson data"),
                  loading: () => SizedBox(
                      height: 600.h,
                      child: const Center(child: CircularProgressIndicator())))
              // LessonInfo()
            ],
          ),
        ),
      ),
    );
  }
}

/*
  error: (error, traceStack) => const Text("Error loading data"),
          loading: () => const Center(child: CircularProgressIndicator()
          )
*/
