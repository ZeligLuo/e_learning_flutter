import 'package:e_learning_app/pages/sign_up/notifier/register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_notifier.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() {
    return RegisterState();
  }

  void onUserNameChange(String userName) {
    state = state.copyWith(userName: userName);
  }

  void onUserEmailChange(String email) {
    state = state.copyWith(email: email);
  }

  void onUserPasswordChange(String password) {
    state = state.copyWith(password: password);
  }

  void onUserCfPasswordChange(String cfPassword) {
    state = state.copyWith(cfPassword: cfPassword);
  }
}