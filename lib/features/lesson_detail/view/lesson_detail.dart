import 'package:e_learning_app/common/utils/app_constants.dart';
import 'package:e_learning_app/common/utils/image_resources.dart';
import 'package:e_learning_app/common/widgets/app_box_decoration.dart';
import 'package:e_learning_app/common/widgets/image_widgets.dart';
import 'package:e_learning_app/common/widgets/popup_messages.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:e_learning_app/features/lesson_detail/controller/lesson_controller.dart';
import 'package:e_learning_app/features/lesson_detail/view/widgets/lesson_detail_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class LessonDetail extends ConsumerStatefulWidget {
  const LessonDetail({super.key});

  @override
  ConsumerState<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends ConsumerState<LessonDetail> {
  late var args;
  int videoIndex = 0;

  @override
  void didChangeDependencies() {
    var id = ModalRoute.of(context)!.settings.arguments as Map;
    args = id["id"];

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var lessonData =
    //     ref.watch(LessonDetailControllerProvider(index: args.toInt()));
    var lessonData = ref.watch(lessonDataControllerProvider);
    // ref.watch(videoIndexControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: lessonData.value == null
            ? const Center(child: CircularProgressIndicator())
            : Column(children: [
                lessonData.when(
                    data: (data) {
                      // print('---lesson thumbnail: ${data.lessonItem[0].thumbnail}---');
                      return Column(
                        children: [
                          // video section
                          Container(
                              width: 325.w,
                              height: 200.h,
                              decoration: data.lessonItem.isEmpty
                                  ? appBoxDecoration()
                                  : networkImageDecoration(
                                      imagePath:
                                          "${AppConstants.IMAGE_UPLOADS_PATH}${data.lessonItem[0].thumbnail}"),
                              child: data.initializeVideoPlayer != null
                                  ? FutureBuilder(
                                      future: data.initializeVideoPlayer,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return videoPlayerController == null
                                              ? Container()
                                              : Stack(
                                                  children: [
                                                    VideoPlayer(
                                                        videoPlayerController!),
                                                  ],
                                                );
                                        } else {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      })
                                  : const Center(
                                      child:
                                          TextNormal(text: "Video is loading"),
                                    )),
                          // video controls section
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.w, right: 25.w, top: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    videoIndex = videoIndex - 1;

                                    if (videoIndex < 0) {
                                      videoIndex = 0;
                                      toastInfo("No previous video!");
                                      return;
                                    }

                                    var videoUrl =
                                        data.lessonItem[videoIndex].url;
                                    ref
                                        .read(lessonDataControllerProvider
                                            .notifier)
                                        .playNextVideo(videoUrl!);
                                    // var indexVal = ref.read(videoIndexControllerProvider.notifier).playPrevAndNext(false);
                                    // if(indexVal == -1){
                                    //   toastInfo("No previous videos!");
                                    // }
                                  },
                                  child: AppImage(
                                      width: 24.w,
                                      height: 24.h,
                                      imagePath: ImageResources.prevIcon),
                                ),
                                SizedBox(width: 15.w),
                                // handle prev btn
                                GestureDetector(
                                  onTap: () {
                                    if (data.isPlay) {
                                      videoPlayerController?.pause();
                                      ref
                                          .read(lessonDataControllerProvider
                                              .notifier)
                                          .playAndPause(false);
                                    } else {
                                      videoPlayerController?.play();
                                      ref
                                          .read(lessonDataControllerProvider
                                              .notifier)
                                          .playAndPause(true);
                                    }
                                  },
                                  child: data.isPlay
                                      ? AppImage(
                                          width: 24.w,
                                          height: 24.h,
                                          imagePath: ImageResources.pauseIcon)
                                      : AppImage(
                                          width: 24.w,
                                          height: 24.h,
                                          imagePath: ImageResources.playIcon),
                                ),
                                SizedBox(width: 15.w),
                                // handle next btn
                                GestureDetector(
                                  onTap: () {
                                    videoIndex += 1;
                                    if (videoIndex >= data.lessonItem.length) {
                                      videoIndex = data.lessonItem.length-1;
                                      toastInfo("No next videos!");
                                      return;
                                    }

                                    var videoUrl =
                                        data.lessonItem[videoIndex].url;
                                    ref
                                        .read(lessonDataControllerProvider
                                            .notifier)
                                        .playNextVideo(videoUrl!);
                                    // var indexVal = ref.read(videoIndexControllerProvider.notifier).playPrevAndNext(true);
                                    // if(indexVal == -1){
                                    //   toastInfo("No next videos!");
                                    // }
                                  },
                                  child: AppImage(
                                      width: 24.w,
                                      height: 24.h,
                                      imagePath: ImageResources.nextIcon),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.only(left: 25.w, right: 25.w),
                            child: LessonVideos(
                                lessonData: data.lessonItem, ref: ref,
                             syncVideoIndex: syncVideoIndex,),
                          )
                        ],
                      );
                    },
                    error: (error, traceStack) => Text(error.toString()),
                    loading: () => const Text("loading"))
              ]),
      ),
    );
  }

  void syncVideoIndex(int index) {
    videoIndex = index;
  }

}
