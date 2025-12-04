import 'dart:convert';

import 'package:doctor_app/app_keys/api_keys.dart';
import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/local_storage/local_storage.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthApiServices {
  AuthApiServices._();

  /// Post Login Api
  static loginApi(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      // LoginModel loginModel=LoginModel(
      //   data:
      // );
      final jsonData = {"email": email, "password": password};
      final url = Uri.parse(ApiKeys.loginKey);

      http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)['data']['access_token'];
        await LocalStorage.saveUserToken(token).then((onValue) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.naveBar,
            (Route<dynamic> route) => false,
          );
        });

        return response;
      } else if (response.statusCode == 401) {
        return AppMsg.showErrorMsg(
          context,
          msg: 'Error : No user found for that email & password',
        );
      } else {
        return AppMsg.showErrorMsg(
          context,
          msg: 'Error : ${response.statusCode}',
        );
      }
    } on Exception catch (err) {
      print(err);
      return AppMsg.showErrorMsg(context, msg: 'Error : ${err.toString()}');
    }
  }
}
