import 'dart:convert';

import 'package:doctor_app/data/local_storage/local_storage.dart';
import 'package:doctor_app/repos/patient_local_repo/patient_local_repo.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:flutter/foundation.dart';

import '../../../core/app_exceptions/app_exceptions.dart';
import '../../../core/app_exceptions/base_exceptions.dart';
import '../../data/api_service/base_api/base_api.dart';
import 'auth_repo_base.dart';

class AuthRepoImpl implements AuthRepoBase {
  BaseApi api;
  ProfileLocalRepo localRepo;
  PatientLocalRepo patientLocalRepo;
  AuthRepoImpl({
    required this.api,
    required this.localRepo,
    required this.patientLocalRepo,
  });
  @override
  Future<LoginModel1> userLogin({
    required String email,
    required String password,
  }) async {
    var jsonResponse = await api.postApi(email: email, password: password);
    print(jsonResponse);
    if (jsonResponse == null) {
      throw AppExceptions(
        message: 'Empty response from server Auth Api Repo',
        debugMessage: 'jsonResponse is null',
      );
    }
    try {
      LoginModel1 model;
      model = LoginModel1.fromJson(jsonResponse['data']);
      if (model.accessToken != null) {
        await localRepo.deleteProfile();
        await localRepo.saveProfile(loginModel: model);
        await localRepo.saveToken(token: model.accessToken.toString());
      }

      return model;
    } catch (e) {
      if (kDebugMode) {
        print("AuthRepo Impl Error: $e");
      }
      throw BaseExceptions(message: e.toString(), debugMessage: e.toString());
    }
  }
}
