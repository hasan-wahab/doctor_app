import 'dart:convert';

import 'package:doctor_app/core/app_exceptions/base_exceptions.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:flutter/foundation.dart';

import '../../core/app_keys/local_keys.dart';
import '../../data/local_storage/local_curd_base/local_curd_base.dart';

class ProfileLocalRepo {
  LocalCurdBase curdBase;
  ProfileLocalRepo({required this.curdBase});

  Future saveProfile({required LoginModel1 loginModel}) async {
    try {
      await curdBase.saveData(
        tableName: TableName.profile,
        key: LocalKeys.profile,
        data: loginModel.toJson(),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Local Repo Error: $e");
      }
      throw BaseExceptions(message: e.toString(), debugMessage: e.toString());
    }
  }

  Future<LoginModel1> getProfile() async {
    List<Map<String, Object?>> jsonData = await curdBase.getData(
      tableName: TableName.profile,
    );
    if (jsonData.isNotEmpty) {
      try {
        LoginModel1 model = LoginModel1.fromJson(
          jsonDecode(jsonData[0][LocalKeys.profile] as String),
        );
        return model;
      } catch (e) {
        throw BaseExceptions(message: e.toString(), debugMessage: e.toString());
      }
    } else {
      throw BaseExceptions(
        message: 'No data found',
        debugMessage: 'No data found',
      );
    }
  }

  Future deleteProfile() async {
    try {
      await curdBase.deleteData(tableName: TableName.profile);
    } catch (e) {
      throw BaseExceptions(message: e.toString(), debugMessage: e.toString());
    }
  }
}
