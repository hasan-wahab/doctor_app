import 'dart:io';

abstract class BaseApi {
  Future postApi({
    required String url,
    String? token,
    String? name,
    String? cnic,
    String? phone,
    String? email,
    String? password,
    String? birthDate,
    String? gender,
  });
  Future getApi({required String url, String? patientId, String? token});

  Future multiPartPostApi({
    required String token,
    required File file,
    required String url,
  });
}
