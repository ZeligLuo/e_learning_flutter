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
Future<void> lessonDetailController(Ref ref,
    {required int index}) async {
  LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
  lessonRequestEntity.id = index;
  final response =
      await LessonRepo.courseLessonDetail(params: lessonRequestEntity);

  if (response.code == 200) {
    var url =
        "${AppConstants.IMAGE_UPLOADS_PATH}${response.data!.elementAt(0).url!}";
    // print('Video url $url');

    videoPlayerController = VideoPlayerController.network(url);

    var initializeVideoPlayerFuture = videoPlayerController?.initialize();
    LessonVideo lessonVideoInstance = LessonVideo(
        lessonItem: response.data!,
        isPlay: true,
        initializeVideoPlayer: initializeVideoPlayerFuture,
        url: url);
    videoPlayerController?.play();
    ref.read(lessonDataControllerProvider.notifier)
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

  void updateLessonData(LessonVideo lessonVideo) {
    update((data) => data.copyWith(
      url: lessonVideo.url,
      initializeVideoPlayer: lessonVideo.initializeVideoPlayer,
      lessonItem: lessonVideo.lessonItem,
      isPlay: lessonVideo.isPlay
    ));
  }

  void playAndPause(bool isPlay) {
    update((data) => data.copyWith(
      isPlay: isPlay
    ));
  }
}
