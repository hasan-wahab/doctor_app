import 'dart:convert';

import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/core/app_exceptions/base_exceptions.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:flutter/foundation.dart';

import '../../core/app_keys/local_keys.dart';
import '../../data/local_storage/local_curd_base/local_curd_base.dart';

class ProfileLocalRepo {
  LocalCurdBase curdBase;
  ProfileLocalRepo({required this.curdBase});

  Future saveProfile({required LoginModel1 loginModel}) async {
    await curdBase.saveData(
      tableName: TableName.profile,
      key: LocalKeys.profile,
      data: loginModel.toJson(),
    );
  }

  Future<LoginModel1> getProfile() async {
    List<Map<String, Object?>> jsonData = await curdBase.getData(
      tableName: TableName.profile,
    );
    if (jsonData.isNotEmpty) {
      LoginModel1 model = LoginModel1.fromJson(
        jsonDecode(jsonData[0][LocalKeys.profile] as String),
      );
      return model;
    } else {
      throw AppExceptions(
        message: 'Error in getting profile Local Repo',
        debugMessage: 'No data found',
      );
    }
  }

  Future deleteProfile() async {
    await curdBase.deleteData(tableName: TableName.profile);
  }

  Future saveToken({required String token}) async {
    await curdBase.saveData(
      tableName: TableName.token,
      key: LocalKeys.token,
      data: token,
    );
  }

  Future<String?> getToken() async {
    var result = await curdBase.getData(tableName: TableName.token);
    if (result.isEmpty) {
      return null;
    }
    var jsonResponseString = result.first[LocalKeys.token];
    if (jsonResponseString == null) {
      return null;
    }
    return jsonDecode(jsonResponseString as String);
  }

  Future deleteToken() async {
    await curdBase.deleteData(tableName: TableName.token);
  }
}
