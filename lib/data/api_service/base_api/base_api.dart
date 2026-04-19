abstract class BaseApi {
  Future postApi({
    required String url,
    String? token,
    String? email,
    String? password,
  });
  Future getApi({required String url, String? patientId, String? token});
}
