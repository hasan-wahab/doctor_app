import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/app_exceptions/app_exceptions.dart';
import '../../../core/app_exceptions/base_exceptions.dart';
import '../../../core/app_keys/api_keys.dart';
import 'base_api.dart';

class BaseApiImpl implements BaseApi {
  @override
  Future postApi({required String email, required String password}) async {
    var url = Uri.parse(ApiKeys.loginKey);
    try {
      http.Response response = await http
          .post(
            url,
            body: jsonEncode({"email": email, "password": password}),
            headers: {"Content-Type": "application/json"},
          )
          .timeout(const Duration(seconds: 10));

      return responseHandle(response);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw TimeOutException();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw BaseExceptions(message: e.toString(), debugMessage: e.toString());
    }
  }

  @override
  Future getApi({required String url, String? patientId, String? token}) async {
    var urL = Uri.parse("$url/$patientId");
    try {
      http.Response response = await http
          .get(
            urL,
            headers: {
              "Accept": "application/json",
              if (token != null) "Authorization": "Bearer $token",
            },
          )
          .timeout(const Duration(seconds: 50));
      return responseHandle(response);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw TimeOutException();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw BaseExceptions(message: e.toString(), debugMessage: e.toString());
    }
  }
}

dynamic responseHandle(http.Response response) {
  var statusCode = response.statusCode;

  switch (statusCode) {
    case 200:
    case 201:
      if (kDebugMode) {
        print(response.body);
      }
      return jsonDecode(response.body);

    case 400:
      throw BadRequestException();
    case 401:
      throw UnauthorisedException();
    case 403:
      throw ForbiddenException();
    case 404:
      throw NotFoundException();
    case 408:
      throw NoInternetException();
    case 500:
      throw ServerException();
    default:
      throw UnknownException();
  }
}
