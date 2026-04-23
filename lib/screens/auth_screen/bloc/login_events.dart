abstract class LoginEvents {}

class LoginSignInEvent extends LoginEvents {
  final String email;
  final String password;
  LoginSignInEvent({required this.email, required this.password});
}


