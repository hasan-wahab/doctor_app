import 'dart:convert';
import 'dart:io';

import 'package:doctor_app/data/local_storage/local_storage.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/repos/all_consultant_assessment_repo/all_consultant_assessmant_local_repo.dart';
import 'package:doctor_app/repos/all_therapy_session_repo/all_therapy_session_local_repo.dart';
import 'package:doctor_app/repos/all_visits_repo/all_visits_local_repo.dart';
import 'package:doctor_app/repos/patient_local_repo/patient_local_repo.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:flutter/foundation.dart';

import '../../../core/app_exceptions/app_exceptions.dart';
import '../../../core/app_exceptions/base_exceptions.dart';
import '../../core/app_keys/api_keys.dart';
import '../../data/api_service/base_api/base_api.dart';
import 'auth_repo_base.dart';

class AuthRepoImpl implements AuthRepoBase {
  BaseApi api;
  ProfileLocalRepo localRepo;
  PatientLocalRepo patientLocalRepo;
  AllVisitLocalRepo allVisitLocalRepo;
  AllConsultantAssessmentLocalRepo allConsultantAssessmentLocalRepo;
  AllTherapySessionLocalRepo allTherapySessionLocalRepo;

  AuthRepoImpl({
    required this.api,
    required this.localRepo,
    required this.patientLocalRepo,
    required this.allVisitLocalRepo,
    required this.allTherapySessionLocalRepo,
    required this.allConsultantAssessmentLocalRepo,
  });

  @override
  Future<LoginModel1> userLogin({
    required String email,
    required String password,
  }) async {
    var jsonResponse = await api.postApi(
      url: ApiKeys.loginKey,
      email: email,
      password: password,
    );
    print(jsonResponse);
    if (jsonResponse == null) {
      throw AppExceptions(
        message: 'Empty response from server Auth Api Repo',
        debugMessage: 'jsonResponse is null',
      );
    }
    LoginModel1 model;
    model = LoginModel1.fromJson(jsonResponse['data']);
    if (model.accessToken != null) {
      await localRepo.saveProfile(loginModel: model);
      await localRepo.saveToken(token: model.accessToken.toString());
    }

    return model;
  }

  @override
  Future logoutUser({required String token, required url}) async {
    if (token.isNotEmpty) {
      await api.postApi(url: ApiKeys.logoutKey, token: token).then((_) {
        if (kDebugMode) {
          print('User Log out');
        }
      });
      await localRepo.deleteToken();
      await localRepo.deleteProfile();
      await patientLocalRepo.deletePatientData();
      await allVisitLocalRepo.deleteAllVisitDataFromLocal();
      await allConsultantAssessmentLocalRepo
          .deleteAllConsultantAssessmentDataFromLocal();
      await allTherapySessionLocalRepo.deleteAllTherapySession();
    }
  }

  @override
  Future updateUserProfile({
    required File file,
    required String name,
    required String email,
    required String cnic,
    required String phone,
    required String token,
    required String birthDate,
    required String gender,
  }) async {
    if (file.path.isNotEmpty) {
      await api.multiPartPostApi(
        token: token,
        file: file,
        url: ApiKeys.updateProfileImageKey,
      );

      var jsonResponse = await api.postApi(
        url: ApiKeys.updateProfileKey,
        token: token,
        email: email,
        cnic: cnic,
        phone: phone,
        name: name,
        gender: gender,
        birthDate: birthDate,
      );
      print('d');

      if (jsonResponse == null) {
        throw AppExceptions(
          message: 'Empty response from server Auth Api Repo',
          debugMessage: 'jsonResponse is null',
        );
      }
      print('e');

      if (jsonResponse != null) {
        LoginModel1 profileData = await localRepo.getProfile();
        if (jsonResponse['data'] != null &&
            jsonResponse['data']['detail'] != null) {
          var detail = jsonResponse['data']['detail'];

          String? phone = detail['phone'];
          String? email = detail['email'];
          String? cnic = detail['cnic'];
          String? name = detail['name'];

          var patientInfo = profileData.patientData?.patientInfo;

          if (patientInfo != null &&
              phone != null &&
              email != null &&
              cnic != null &&
              name != null) {
            patientInfo.phone = phone;
            patientInfo.email = email;
            patientInfo.cnic = cnic;
            patientInfo.name = name;
            print(" ${"$name  $phone  $email  $cnic"}");
            print('f');

            await localRepo.deleteProfile();
            print('g');

            await localRepo.saveProfile(loginModel: profileData);
          }
        }
      }
    } else {

      var jsonResponse = await api.postApi(
        url: ApiKeys.updateProfileKey,
        token: token,
        email: email,
        cnic: cnic,
        phone: phone,
        name: name,
        gender: gender,
        birthDate: birthDate,
      );

      if (jsonResponse == null) {
        throw AppExceptions(
          message: 'Empty response from server Auth Api Repo',
          debugMessage: 'jsonResponse is null',
        );
      }

      if (jsonResponse != null) {
        LoginModel1 profileData = await localRepo.getProfile();
        if (jsonResponse['data'] != null &&
            jsonResponse['data']['detail'] != null) {
          var detail = jsonResponse['data']['detail'];

          String? phone = detail['phone'];
          String? email = detail['email'];
          String? cnic = detail['cnic'];
          String? name = detail['name'];

          var patientInfo = profileData.patientData?.patientInfo;

          if (patientInfo != null &&
              phone != null &&
              email != null &&
              cnic != null &&
              name != null) {
            patientInfo.phone = phone;
            patientInfo.email = email;
            patientInfo.cnic = cnic;
            patientInfo.name = name;
            print(" ${"$name  $phone  $email  $cnic"}");

            await localRepo.deleteProfile();

            await localRepo.saveProfile(loginModel: profileData);
          }
        }
      }
    }
  }
}
