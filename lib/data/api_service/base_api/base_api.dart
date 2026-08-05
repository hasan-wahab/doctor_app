import 'dart:io';

abstract class BaseApi {
  Future

  postApi({
    required String url,
    String? token,
    String? name,
    String? cnic,
    String? phone,
    String? email,
    String? password,
    String? birthDate,
    String? gender,
    Map? body
  });
  Future getApi({required String url, String? patientId, String? token});

  Future putApi({
    required String url,
    String? token,
    Map? body,
  });

  Future multiPartPostApi({
    required String token,
    required File file,
    required String url,
  });
}
