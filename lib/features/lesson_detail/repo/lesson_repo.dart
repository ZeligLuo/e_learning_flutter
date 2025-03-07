import 'package:e_learning_app/common/models/lesson_entities.dart';
import 'package:e_learning_app/common/services/http_util.dart';

class LessonRepo {
  static Future<LessonDetailResponseEntity> courseLessonDetail(
      {LessonRequestEntity? params}) async {
    var response = await HttpUtil()
        .post("api/lessonDetail", queryParameters: params?.toJson());

    return LessonDetailResponseEntity.fromJson(response);
  }
}