import 'dart:convert';

import 'package:doctor_app/core/app_keys/local_keys.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/models/all_visits_model.dart';

class AllVisitLocalRepo {
  LocalCurdBase localCurdBase;
  AllVisitLocalRepo({required this.localCurdBase});

  Future saveAllVisitsInLocal({required AllVisitsModel model}) async {
    await localCurdBase.saveData(
      tableName: TableName.allVisits,
      key: LocalKeys.allVisitKey,
      data: model.toJson(),
    );
  }

  Future<AllVisitsModel> getAllVisitFromLocal() async {
    final result = await localCurdBase.getData(tableName: TableName.allVisits);

    if (result.isEmpty) {
      print("⚠️ No local patient data found");
      return AllVisitsModel(visits: []);
    }
    var patientJsonString = result.first[LocalKeys.allVisitKey];
    if (patientJsonString == null) {
      print("⚠️ patientKey is null");
      return AllVisitsModel(visits: []);
    }
    AllVisitsModel model = AllVisitsModel.fromJson(
      jsonDecode(patientJsonString as String),
    );
    return model;
  }

  Future deleteAllVisitDataFromLocal() async {
    await localCurdBase.deleteData(tableName: TableName.allVisits);
  }
}
