import 'dart:convert';
import 'dart:io';

import 'package:doctor_app/app_keys/api_keys.dart';
import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/local_storage/local_storage.dart';
import 'package:doctor_app/models/current_patient_model.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthApiServices {
  AuthApiServices._();

  /// Post Login Api Call

  static loginApi(
    BuildContext context, {
    required String email,
    required String password,
    bool isLoginCall = true,
  }) async {
    try {
      final jsonData = {"email": email, "password": password};
      final url = Uri.parse(ApiKeys.loginKey);

      http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        String token = data['data']['access_token'];
        print(token);
        Map<String, dynamic> profileData = data['data'];
        print(profileData);
        await LocalStorage.saveProfileData(token, jsonEncode(profileData));
        await LocalStorage.saveUserToken(token).then((onValue) async {
          await LocalStorage.saveProfileData('password', password.toString());
          if (isLoginCall == true) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.naveBar,
              (Route<dynamic> route) => false,
            );
          } else {}
        });
        return response;
      } else if (response.statusCode == 401) {
        return AppMsg.showErrorMsg(
          context,
          msg: 'Error : No user found for that email & password',
        );
      } else {
        return AppMsg.showErrorMsg(
          context,
          msg: 'Error : ${response.statusCode}',
        );
      }
    } on Exception catch (err) {
      print(err);
      return AppMsg.showErrorMsg(context, msg: 'Error : ${err.toString()}');
    }
  }

  /// Update current user profile

  static Future<void> updateApiCall({
    required String name,
    required String email,
    required String cnic,
    required String phone,
    required String currentUserToken,
  }) async {
    final updateUrl = Uri.parse(
      "${ApiKeys.updateProfileKey}?t=${DateTime.now().millisecondsSinceEpoch}",
    );

    http.Response response = await http.post(
      updateUrl,
      body: jsonEncode({
        "name": name,
        "email": email,
        "cnic": cnic,
        "phone": phone,
      }),
      headers: {
        "Authorization": "Bearer $currentUserToken",
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Cache-Control": "no-cache, no-store, must-revalidate",
        "Pragma": "no-cache",
        "Expires": "0",
      },
    );

    if (response.statusCode == 200) {
      final currentUserToken = await LocalStorage.getUserToken('token');
      final getOldUserData = await LocalStorage.getProfileData(
        currentUserToken!,
      );

      /// Convert to json
      final updatedData = jsonDecode(response.body);

      /// Convert string to json

      final data = jsonDecode(getOldUserData!);

      /// Update data in our Local Storage

      data['user']['name'] = updatedData['data']['name'];
      data['user']['profile_picture'] = updatedData['data']['profile_picture'];
      data['user']['email'] = updatedData['data']['email'];
      data['user']['cnic'] = updatedData['data']['cnic'];
      data['patient_data']['patient_info']['cnic'] =
          updatedData['data']['cnic'];
      data['patient_data']['patient_info']['email'] =
          updatedData['data']['email'];
      data['patient_data']['patient_info']['phone'] =
          updatedData['data']['phone'];
      data['patient_data']['patient_info']['image'] =
          updatedData['data']['profile_picture'];
      final updateData = data;
      await LocalStorage.saveProfileData(
        currentUserToken,
        jsonEncode(updateData),
      );

      print(updateData);
    } else {
      print("Status: ${response.statusCode}");
    }
  }

  /// Update current user profile image

  static Future<bool> updateProfileImage(
    File path,
    currentUserToken,
    BuildContext context,
  ) async {
    final url = Uri.parse('${ApiKeys.baseUrl}/patient/profile-picture');
    final request = await http.MultipartRequest('Post', url);

    request.headers["Authorization"] = "Bearer $currentUserToken";
    request.headers["Accept"] = "application/json";
    request.files.add(
      await http.MultipartFile.fromPath('profile_picture', path.path),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image updated!");
      return true;
    } else {
      AppMsg.showErrorMsg(context, msg: response.statusCode.toString());
      return false;
    }
  }

  /// Logout Api Call

  static Future<void> logoutUser(currentUserToken) async {
    final url = Uri.parse('${ApiKeys.baseUrl}/patient/logout');
    final http.Response response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $currentUserToken",
        "Accept": "application/json",
      },
    );

    print(response.body);
  }

  /// Get api | Current patient appointment data

  static Future getPatientData({
    required String patientId,
    required String currentUserToken,
    required BuildContext context,
  }) async {
    try {
      final url = Uri.parse(
        '${ApiKeys.baseUrl}/patient/apipatients/$patientId',
      );

      http.Response response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $currentUserToken",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        CurrentPatientModel currentPatientData = CurrentPatientModel.fromJson(
          jsonData['data'],
        );

        return currentPatientData;
      } else {
        AppMsg.showErrorMsg(context, msg: response.statusCode.toString());
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
