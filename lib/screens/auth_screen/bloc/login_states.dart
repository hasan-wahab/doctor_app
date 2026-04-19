class LoginState {}

class LoginInitState extends LoginState {
  final String email;
  final String password;
  LoginInitState({this.email = '', this.password = ''});

  LoginInitState copyWith({String? email, String? password}) {
    return LoginInitState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  String? error;
  LoginErrorState({this.error = ''});
}

class LoginSuccessState extends LoginState {}

class LoginUserLogoutSuccessState extends LoginState {}
