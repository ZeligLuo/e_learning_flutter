import 'package:e_learning_app/common/widgets/search_widgets.dart';
import 'package:e_learning_app/features/home/controller/home_controller.dart';
import 'package:e_learning_app/features/home/view/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late PageController _controller;

  @override
  void didChangeDependencies() {
    _controller =
        PageController(initialPage: ref.watch(homeScreenBannerDotsProvider));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppBar(ref),
      body: RefreshIndicator(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  const HelloText(),
                  const UserName(),
                  SizedBox(height: 20.h),
                  searchBar(),
                  SizedBox(height: 20.h),
                  HomeBanner(controller: _controller, ref: ref),
                  const HomeMenuBar(),
                  // CustomScrollView(
                  //   physics: const ScrollPhysics(),
                  //   shrinkWrap: true,
                  //   slivers: [
                  //     SliverPadding(
                  //       padding: EdgeInsets.all(20),
                  //       sliver: SliverGrid.count(
                  //         crossAxisCount: 2,
                  //         crossAxisSpacing: 10,
                  //         children: [
                  //           Text("data"),
                  //           Text("data"),
                  //           Text("data"),
                  //           Text("data"),
                  //           Text("data")
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // )
                  CourseItemGrid(ref: ref)
                ],
              ),
            ),
          ),
          onRefresh: () {
            return ref.refresh(homeCourseListProvider.notifier).fetchCourseList();
          }),
    );
  }
}
