import 'package:e_learning_app/common/api/course_api.dart';
import 'package:e_learning_app/common/models/course_entities.dart';
import 'package:e_learning_app/common/models/entities.dart';
import 'package:e_learning_app/global.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_controller.g.dart';

@Riverpod(keepAlive: true)
class HomeScreenBannerDots extends _$HomeScreenBannerDots {
  @override
  int build() => 0;

  void setIndex(int value) {
    state = value;
  }
}

@riverpod
class HomeUserProfile extends _$HomeUserProfile {

  @override
  FutureOr<UserProfile> build() {
    return Global.storageService.getUserProfile();
  }
}

@riverpod
class HomeCourseList extends _$HomeCourseList {

  Future<List<CourseItem>?> fetchCourseList() async {
    var result = await CourseApi.courseList();

    if(result.code == 200) {
      return result.data;
    }
    return null;
  }

  @override
  FutureOr<List<CourseItem>?> build() async {
    return fetchCourseList();
  }
}