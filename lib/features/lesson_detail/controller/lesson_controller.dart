import 'package:e_learning_app/common/models/lesson_entities.dart';
import 'package:e_learning_app/common/utils/app_constants.dart';
import 'package:e_learning_app/features/lesson_detail/repo/lesson_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';
part 'lesson_controller.g.dart';

VideoPlayerController? videoPlayerController;

@riverpod
Future<void> lessonDetailController(Ref ref, {required int index}) async {
  LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
  lessonRequestEntity.id = index;
  final response =
      await LessonRepo.courseLessonDetail(params: lessonRequestEntity);

  if (response.code == 200) {
    var lessonItem = response.data!.elementAt(0);
    if (lessonItem.video == null || lessonItem.video!.isEmpty) {
      if (kDebugMode) {
        print('This lesson has no video.');
      }
      return;
    }

    var url =
        "${AppConstants.IMAGE_UPLOADS_PATH}${response.data!.elementAt(0).video![0].url}";
    // if (kDebugMode) {
    //   print('Video url $url');
    // }

    // videoPlayerController = VideoPlayerController.network(url);
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));

    var initializeVideoPlayerFuture = videoPlayerController?.initialize();

    videoPlayerController?.play();

    LessonVideo lessonVideoInstance = LessonVideo(
        lessonItem: lessonItem.video ?? [],
        isPlay: true,
        initializeVideoPlayer: initializeVideoPlayerFuture,
        url: url);

    ref
        .read(lessonDataControllerProvider.notifier)
        .updateLessonData(lessonVideoInstance);
  } else {
    if (kDebugMode) {
      print('request fail ${response.code}');
    }
  }
}

@riverpod
class LessonDataController extends _$LessonDataController {
  @override
  FutureOr<LessonVideo> build() async {
    return LessonVideo();
  }

  @override
  set state(AsyncValue<LessonVideo> newState) {
    // print('Video state: ${newState.value!.lessonItem.first.url}');
    super.state = newState;
  }

  void updateLessonData(LessonVideo lessonVideo) {
    update((data) => lessonVideo);
    // update((data) => data.copyWith(
    //     url: lessonVideo.url,
    //     initializeVideoPlayer: lessonVideo.initializeVideoPlayer,
    //     lessonItem: lessonVideo.lessonItem,
    //     isPlay: lessonVideo.isPlay));
  }

  void playAndPause(bool isPlay) {
    update((data) => data.copyWith(isPlay: isPlay));
  }

  Future<void> playNextVideo(String url) async {
    if (videoPlayerController != null) {
      videoPlayerController?.pause();
      videoPlayerController?.dispose();
    }
    update((data) => data.copyWith(isPlay: false, initializeVideoPlayer: null));

    var vidUrl = "${AppConstants.IMAGE_UPLOADS_PATH}$url";
    // if (kDebugMode) {
    //   print(vidUrl.toString());
    // }
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(vidUrl));
    var initializeVideoPlayerFuture =
        videoPlayerController?.initialize().then((value) {
      videoPlayerController?.seekTo(
          const Duration(seconds: 0)); // force video start at the beginning second
      videoPlayerController?.play();
    });

    update((data) => data.copyWith(
        initializeVideoPlayer: initializeVideoPlayerFuture,
        isPlay: true,
        url: vidUrl));
  }
}
