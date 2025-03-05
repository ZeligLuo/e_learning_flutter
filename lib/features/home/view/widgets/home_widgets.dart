import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/utils/app_constants.dart';
import 'package:e_learning_app/common/utils/image_resources.dart';
import 'package:e_learning_app/common/widgets/app_box_decoration.dart';
import 'package:e_learning_app/common/widgets/image_widgets.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:e_learning_app/features/home/controller/home_controller.dart';
import 'package:e_learning_app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelloText extends StatelessWidget {
  const HelloText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const TextNormal(
          text: "Hello, ", fontWeight: FontWeight.bold, fontSize: 24),
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextNormal(
          text: Global.storageService.getUserProfile().name!,
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize: 24),
    );
  }
}

class HomeBanner extends StatelessWidget {
  final PageController controller;
  final WidgetRef ref;

  const HomeBanner({super.key, required this.controller, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // banner img
        SizedBox(
          width: 325.w,
          height: 160.h,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              ref.read(homeScreenBannerDotsProvider.notifier).setIndex(index);
            },
            children: [
              bannerContainer(imagePath: ImageResources.banner1),
              bannerContainer(imagePath: ImageResources.banner2),
              bannerContainer(imagePath: ImageResources.banner3)
            ],
          ),
        ),
        SizedBox(height: 5.h),
        // dots
        DotsIndicator(
          position: ref.watch(homeScreenBannerDotsProvider),
          dotsCount: 3,
          mainAxisAlignment: MainAxisAlignment.center,
          decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(24.0, 8.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.w))),
        )
      ],
    );
  }
}

Widget bannerContainer({required String imagePath}) {
  return Container(
    width: 325.w,
    height: 140.h,
    decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill)),
  );
}

AppBar homeAppBar(WidgetRef ref) {
  var profileState = ref.watch(homeUserProfileProvider);

  return AppBar(
    title: Container(
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppImage(imagePath: ImageResources.menu, width: 18.w, height: 12.h),
          profileState.when(
              data: (value) => GestureDetector(
                    child: AppBoxDecorationImage(
                        imagePath:
                            "${AppConstants.SERVER_API_URL}${value.avatar!}"),
                  ),
              error: (error, stack) => AppImage(
                  imagePath: ImageResources.profileIcon,
                  width: 18.w,
                  height: 12.h),
              loading: () => Container())
        ],
      ),
    ),
  );
}

class HomeMenuBar extends StatelessWidget {
  const HomeMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // see all course
        Container(
          margin: EdgeInsets.only(top: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const TextNormal(
                  text: "Choose your course",
                  fontSize: 16,
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold),
              GestureDetector(
                child: const TextNormal(text: "See all", fontSize: 12),
              )
            ],
          ),
        ),
        SizedBox(height: 15.h),
        // course tab
        Row(
          children: [
            Container(
              decoration: appBoxDecoration(
                  color: AppColors.primaryElement, radius: 7.w),
              padding: EdgeInsets.only(
                  left: 15.w, right: 15.w, top: 5.h, bottom: 5.h),
              child: const TextNormal(
                  text: "All",
                  color: AppColors.primaryElementText,
                  fontSize: 11),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.w),
              child: const TextNormal(
                  text: "Popular",
                  color: AppColors.primaryThirdElementText,
                  fontSize: 11),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.w),
              child: const TextNormal(
                  text: "Newest",
                  color: AppColors.primaryThirdElementText,
                  fontSize: 11),
            )
          ],
        )
      ],
    );
  }
}

class CourseItemGrid extends StatelessWidget {
  final WidgetRef ref;

  const CourseItemGrid({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    final courseState = ref.watch(homeCourseListProvider);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 0),
      child: courseState.when(
          data: (data) => GridView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.5),
              itemCount: data?.length,
              itemBuilder: (_, int index) {
                return AppBoxDecorationImage(
                  imagePath:
                      "${AppConstants.IMAGE_UPLOADS_PATH}${data![index].thumbnail!}",
                  boxFit: BoxFit.cover,
                  courseItem: data[index],
                  func: () {
                    // print(data[index].id.toString());
                    Navigator.of(context).pushNamed("/course_detail", arguments: {
                      "id":data[index].id!
                    });
                  },
                );
              }),
          error: (error, stackTrace) {
            // print(error.toString());
            // print(stackTrace.toString());
            return const Center(child: Text("Error"));
          },
          loading: () => const Center(child: Text("Loading..."))),
    );
  }
}
