class SignInState {
  final String email;
  final String password;

  const SignInState({this.email = '', this.password = ''});

  SignInState copyWith(
      {String? userName, String? email, String? password, String? cfPassword}) {
    return SignInState(
        email: email ?? this.email, password: password ?? this.password);
  }
}
