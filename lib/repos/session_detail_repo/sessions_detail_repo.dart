import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api.dart';
import 'package:doctor_app/data/models/consultant_assesment_model.dart';
import 'package:doctor_app/data/models/therapay_session_model.dart';

class SessionsDetailRepo {
  final BaseApi api;
  SessionsDetailRepo({required this.api});
  Future<TherapySessionsResponseModel> getConsultantsAssessmentByVisitId({
    required String visitId,
    required String token,
  }) async {
    var jsonResponse = await api.getApi(
      url: ApiKeys.sessionDetailKey,
      patientId: visitId,
      token: token,
    );

    if (jsonResponse == null) {
      throw AppExceptions(message: 'JsonResponse Null');
    }

    TherapySessionsResponseModel model = TherapySessionsResponseModel.fromJson(
      jsonResponse['data'],
    );

    return model;
  }
}
