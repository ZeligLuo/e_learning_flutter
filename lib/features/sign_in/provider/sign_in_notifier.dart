import 'package:e_learning_app/features/sign_in/provider/sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier stores state
class SignInNotifier extends StateNotifier<SignInState> {
  SignInNotifier() : super(const SignInState());

  void onUserEmailChange(String email) {
    state = state.copyWith(email: email);
  }

  void onUserPasswordChange(String password) {
    state = state.copyWith(password: password);
  }
}

final signInNotifierProvider =
    StateNotifierProvider<SignInNotifier, SignInState>((ref) {
  return SignInNotifier();
});
