import 'dart:convert';

import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/models/all_therapist_model.dart';
import 'package:flutter/foundation.dart';

import '../../core/app_keys/local_keys.dart';

class AllTherapySessionLocalRepo {
  LocalCurdBase localCurdBase;
  AllTherapySessionLocalRepo({required this.localCurdBase});

  Future saveAllTherapySession({required AllTherapistModel model}) async {
    await localCurdBase.saveData(
      tableName: TableName.allTherapistSession,
      key: LocalKeys.allTherapistSessionKey,
      data: model.toJson(),
    );
  }

  Future<AllTherapistModel> getAllTherapySession() async {
    var result = await localCurdBase.getData(
      tableName: TableName.allTherapistSession,
    );

    if (result.isEmpty) {
      if (kDebugMode) {
        print('⚠️ No local patient data found');
        return AllTherapistModel.fromJson([]);
      }
    }
    var allTherapySessionJsonString =
        result.first[LocalKeys.allTherapistSessionKey];
    if (allTherapySessionJsonString == null) {
      if (kDebugMode) {
        print('⚠️ patientKey is null');

        return AllTherapistModel.fromJson([]);
      }
    }
    AllTherapistModel model = AllTherapistModel.fromJson(
      jsonDecode(allTherapySessionJsonString as String),
    );
    return model;
  }

  Future deleteAllTherapySession() async {
    await localCurdBase.deleteData(tableName: TableName.allTherapistSession);
  }
}
