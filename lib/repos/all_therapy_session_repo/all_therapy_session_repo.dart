import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api.dart';
import 'package:doctor_app/data/models/all_therapist_model.dart';
import 'package:doctor_app/repos/all_therapy_session_repo/all_therapy_session_local_repo.dart';
import 'package:flutter/foundation.dart';

class AllTherapySessionRepo {
  BaseApi api;
  AllTherapySessionLocalRepo localRepo;
  AllTherapySessionRepo({required this.api, required this.localRepo});

  Future<AllTherapistModel> getAllTherapySession({
    required String token,
    required String patientId,
  }) async {
    AllTherapistModel model;
    final jsonResponse = await api.getApi(
      url: ApiKeys.allTherapistKey,
      token: token,
      patientId: patientId,
    );
    if (jsonResponse != null) {
      if (kDebugMode) {
        print('From $jsonResponse');
      }
      final dynamic visitWiseSessions =
          jsonResponse['data']?['visit_wise_sessions'];
      if (visitWiseSessions == null) {
        throw AppExceptions(message: 'Json response data is null');
      }
      model = AllTherapistModel.fromJson(visitWiseSessions);
      await localRepo.deleteAllTherapySession();
      await localRepo.saveAllTherapySession(model: model);

      return model;
    } else {
      throw AppExceptions(message: 'Json response is null');
    }
  }
}
