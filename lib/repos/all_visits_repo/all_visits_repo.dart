import 'dart:convert';

import 'package:doctor_app/data/api_service/base_api/base_api.dart';
import 'package:doctor_app/data/models/all_visits_model.dart';
import 'package:doctor_app/repos/all_visits_repo/all_visits_local_repo.dart';
import 'package:flutter/cupertino.dart';

import '../../core/app_exceptions/app_exceptions.dart';
import '../../core/app_keys/api_keys.dart';

class AllVisitRepo {
  BaseApi api;
  AllVisitLocalRepo allVisitLocalRepo;

  AllVisitRepo({required this.api, required this.allVisitLocalRepo});

  Future<AllVisitsModel> allVisits({
    required String token,
    required String patientId,
  }) async {
    var jsonResponse = await api.getApi(
      url: ApiKeys.allVisitsKey,
      token: token,
      patientId: patientId,
    );

    if (jsonResponse != null) {
      var jsonListResponse = jsonResponse['data']['visits'];
      await allVisitLocalRepo.deleteAllVisitDataFromLocal();
      await allVisitLocalRepo.saveAllVisitsInLocal(
        model: AllVisitsModel.fromJson(jsonListResponse),
      );
      return AllVisitsModel.fromJson(jsonListResponse);
    } else {
      throw AppExceptions(message: 'JsonResponse Null');
    }
  }
}
