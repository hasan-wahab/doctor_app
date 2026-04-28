import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api.dart';
import 'package:doctor_app/data/models/consultant_assesment_model.dart';

class ConsultantAssessmentRepo {
  final BaseApi api;
  ConsultantAssessmentRepo({required this.api});
  Future<ConsultantAssessmentModel> getConsultantsAssessmentByVisitId({
    required String visitId,
    required String token,
  }) async {
    var jsonResponse = await api.getApi(
      url: ApiKeys.consultantAssessmentKey,
      patientId: visitId,
      token: token,
    );

    if (jsonResponse == null) {
      throw AppExceptions(message: 'JsonResponse Null');
    }

    ConsultantAssessmentModel model = ConsultantAssessmentModel.fromJson(
      jsonResponse['data'],
    );

    return model;
  }
}
