import 'dart:convert';

import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';

import '../../core/app_keys/local_keys.dart';
import '../../data/models/all_consutant_assessment_model.dart';

class AllConsultantAssessmentLocalRepo {
  LocalCurdBase localCurdBase;
  AllConsultantAssessmentLocalRepo({required this.localCurdBase});

  Future saveAllConsultantAssessmentInLocal({
    required List<AllConsultantAssessmentModel> model,
  }) async {
    await localCurdBase.saveData(
      tableName: TableName.allConsultantAssessment,
      key: LocalKeys.allConsultantAssessmentKey,
      data: model.map((e) => e.toJson()).toList(),
    );
  }

  Future<List<AllConsultantAssessmentModel>>
  getAllConsultantAssessmentFromLocal() async {
    List<AllConsultantAssessmentModel> model = [];

    final result = await localCurdBase.getData(
      tableName: TableName.allConsultantAssessment,
    );
    if (result.isEmpty) {
      print("⚠️ No local patient data found");
      return model;
    }
    var patientJsonString = result.first[LocalKeys.allConsultantAssessmentKey];
    if (patientJsonString == null) {
      print("⚠️ patientKey is null");
      return model;
    }
    var jsonDecoded = jsonDecode(patientJsonString);
    for (var element in jsonDecoded) {
      model.add(AllConsultantAssessmentModel.fromJson(element));
    }

    return model;
  }

  Future deleteAllConsultantAssessmentDataFromLocal() async {
    await localCurdBase.deleteData(
      tableName: TableName.allConsultantAssessment,
    );
  }
}
