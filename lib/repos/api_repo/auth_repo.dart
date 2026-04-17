import 'dart:convert';

import 'package:doctor_app/data/local_storage/local_storage.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:flutter/foundation.dart';

import '../../../core/app_exceptions/app_exceptions.dart';
import '../../../core/app_exceptions/base_exceptions.dart';
import '../../data/api_service/base_api/base_api.dart';
import 'auth_repo_base.dart';

class AuthRepoImpl implements AuthRepoBase {
  BaseApi api;
  AuthRepoImpl({required this.api});
  @override
  Future<LoginModel1> userLogin({
    required String email,
    required String password,
  }) async {
    var jsonResponse = await api.postApi(email: email, password: password);
    print(jsonResponse);
    if (jsonResponse == null) {
      throw AppExceptions(
        message: 'Empty response from server',
        debugMessage: 'jsonResponse is null',
      );
    }
    try {
      LoginModel1 model1;
      model1 = LoginModel1.fromJson(jsonResponse['data']);
      if (model1.accessToken != null) {
        await LocalStorage.saveProfileData(
          model1.accessToken.toString(),
          jsonEncode(model1.toJson()),
        ).then((_) async {
          await LocalStorage.saveUserToken(model1.accessToken.toString());
        });
      }

      return model1;
    } catch (e) {
      throw BaseExceptions(message: e.toString(), debugMessage: e.toString());
    }
  }
}
