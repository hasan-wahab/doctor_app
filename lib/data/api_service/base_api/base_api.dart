abstract class BaseApi {
  Future postApi({required String email, required String password});
  Future getApi({required String url, String? patientId, String? token});
}
