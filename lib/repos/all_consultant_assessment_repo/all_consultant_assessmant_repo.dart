import 'dart:convert';

import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/models/all_consutant_assessment_model.dart';
import 'package:doctor_app/repos/all_consultant_assessment_repo/all_consultant_assessmant_local_repo.dart';

import '../../core/app_exceptions/app_exceptions.dart';

class AllConsultantAssessmentRepo {
  BaseApi api;
  AllConsultantAssessmentLocalRepo allConsultantAssessmentLocalRepo;
  AllConsultantAssessmentRepo({
    required this.api,
    required this.allConsultantAssessmentLocalRepo,
  });

  Future<List<AllConsultantAssessmentModel>> getAllConsultantAssessment({
    required String token,
    required String patientId,
  }) async {
    var jsonResponse = await api.getApi(
      url: ApiKeys.allConsultantKey,
      patientId: patientId,
      token: token,
    );
    if (jsonResponse != null) {
      List<AllConsultantAssessmentModel> allConsultantAssessmentList = [];
      var jsonListResponse = jsonResponse['data']['assessments'];
      for (var a in jsonListResponse) {
        print(a);
        allConsultantAssessmentList.add(
          AllConsultantAssessmentModel.fromJson(a),
        );
      }
      await allConsultantAssessmentLocalRepo
          .deleteAllConsultantAssessmentDataFromLocal();
      await allConsultantAssessmentLocalRepo.saveAllConsultantAssessmentInLocal(
        model: allConsultantAssessmentList,
      );
      return allConsultantAssessmentList;
    } else {
      throw AppExceptions(message: 'Null jsonResponse');
    }
  }
}
