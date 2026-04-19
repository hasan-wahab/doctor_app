import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';

abstract class AuthRepoBase {
  Future<LoginModel1> userLogin({
    required String email,
    required String password,
  });

  Future logoutUser({required String token, required url});
}
