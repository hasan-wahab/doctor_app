import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/models/history_traker_model.dart';

class HistoryTrackerRepoImpl {
  BaseApi api;
  LocalCurdBase curdBase;
  HistoryTrackerRepoImpl({required this.api, required this.curdBase});

  Future<HistoryTrackerModel> getHistoryTracker({
    required String token,
    required String visitId,
  }) async {
    var jsonResponse = await api.getApi(
      url: ApiKeys.historyTrackerKey,
      patientId: visitId,
      token: token,
    );

    if (jsonResponse != null) {
      print(jsonResponse['data']);
      return HistoryTrackerModel.fromJson(jsonResponse['data']);
    } else {
      throw AppExceptions(message: 'jsonResponse is null');
    }
  }
}
