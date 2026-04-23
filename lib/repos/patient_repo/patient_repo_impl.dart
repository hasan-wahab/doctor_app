import 'dart:convert';

import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/core/app_exceptions/base_exceptions.dart';
import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/core/app_keys/local_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/repos/patient_local_repo/patient_local_repo.dart';
import 'package:doctor_app/repos/patient_repo/patient_repo_base.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';

class PatientRepoImpl implements PatientRepoBase {
  BaseApi api;
  ProfileLocalRepo profileLocalRepo;
  LocalCurdBase curdBase;
  PatientLocalRepo patientLocalRepo;
  PatientRepoImpl({
    required this.api,
    required this.profileLocalRepo,
    required this.curdBase,
    required this.patientLocalRepo,
  });
  @override
  Future<CurrentPatientModel> getPatientData() async {

    LoginModel1 userData = await profileLocalRepo.getProfile();

    dynamic jsonData = await api.getApi(
      url: ApiKeys.getPatientKey,
      patientId: userData.patientData!.patientInfo!.id.toString(),
      token: userData.accessToken.toString(),
    );

    if (jsonData != null) {
      CurrentPatientModel model = CurrentPatientModel.fromJson(
        jsonData['data'],
      );
      print(model);
      await patientLocalRepo.deletePatientData();
      await patientLocalRepo.savePatientDataLocal(model);

      return model;
    } else {
      throw AppExceptions(
        message: 'Empty response from server Patient Api Repo',
        debugMessage: 'jsonResponse is null',
      );
    }

  }

  @override
  Future deletePatientData() async {

      await curdBase.deleteData(tableName: TableName.patientData);

  }

  @override
  Future updatePatientData() async {
    // try{
    //   await api.postApi(url: ApiKeys.updateProfileKey, );
    // }
  }
}
