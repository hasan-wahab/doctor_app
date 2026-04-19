import 'dart:convert';

import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/core/app_exceptions/base_exceptions.dart';
import 'package:doctor_app/core/app_keys/local_keys.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/current_patient_model.dart';

class PatientLocalRepo {
  LocalCurdBase curdBase;
  PatientLocalRepo({required this.curdBase});
  Future savePatientDataLocal(CurrentPatientModel model) async {
    try {
      await curdBase.saveData(
        tableName: TableName.patientData,
        key: LocalKeys.patientKey,
        data: model.toJson(),
      );
    } catch (e) {
      throw AppExceptions(
        debugMessage: 'Save Patient Local Data Error Repo',
        message: e.toString(),
      );
    }
  }

  Future<CurrentPatientModel?> getPatientDataLocal() async {
    try {
      var data = await curdBase.getData(tableName: TableName.patientData);

      if (data.isEmpty) {
        print("⚠️ No local patient data found");
        return null;
      }

      var patientJsonString = data.first[LocalKeys.patientKey];

      if (patientJsonString == null) {
        print("⚠️ patientKey is null");
        return null;
      }

      CurrentPatientModel model = CurrentPatientModel.fromJson(
        jsonDecode(patientJsonString as String),
      );
      return model;
    } catch (e) {
      throw AppExceptions(
        debugMessage: e.toString(),
        message: 'Get Patient Local Data Error Repo',
      );
    }
  }

  Future deletePatientData() async {
    try {
      await curdBase.deleteData(tableName: TableName.patientData);
    } catch (e) {
      throw AppExceptions(
        message: 'Delete Patient local Data Error Repo',
        debugMessage: e.toString(),
      );
    }
  }
}
