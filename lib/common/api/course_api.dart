import 'package:e_learning_app/common/models/course_entities.dart';
import 'package:e_learning_app/common/services/http_util.dart';

class CourseApi {
  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().post(
      'api/courseList'
    );

    return CourseListResponseEntity.fromJson(response);
  }
}