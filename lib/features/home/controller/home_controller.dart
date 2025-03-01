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