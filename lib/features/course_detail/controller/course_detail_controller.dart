import 'package:e_learning_app/common/models/course_entities.dart';
import 'package:e_learning_app/features/course_detail/repo/course_detail_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'course_detail_controller.g.dart';

@riverpod
Future<CourseItem?> courseDetailController(Ref ref, {required int index}) async {
  CourseRequestEntity courseRequestEntity = CourseRequestEntity();
  courseRequestEntity.id = index;
  final response = await CourseDetailRepo.courseDetail(params: courseRequestEntity);

  if(response.code == 200) {
    return response.data;
  } else {
    if (kDebugMode) {
      print('request fail ${response.code}');
    }
  }

  return null;
}