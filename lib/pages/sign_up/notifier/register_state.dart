class RegisterState {
  final String userName;
  final String email;
  final String password;
  final String cfPassword;

  RegisterState(
      {this.userName = '',
      this.email = '',
      this.password = '',
      this.cfPassword = ''});

  RegisterState copyWith(
      {String? userName, String? email, String? password, String? cfPassword}) {
    return RegisterState(
        userName: userName ?? this.userName,
        email: email ?? this.email,
        password: password ?? this.password,
        cfPassword: cfPassword ?? this.cfPassword);
  }
}
