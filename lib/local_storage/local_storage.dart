import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  static Future<bool> saveUserToken(String tokenValue) async {
    final preferences = await SharedPreferences.getInstance();
    final prefs = await preferences.setString('token', tokenValue);
    return prefs;
  }

  static Future<String?> getUserToken() async {
    final preferences = await SharedPreferences.getInstance();

    final prefs = await preferences.getString('token');
    return prefs;
  }

  static Future<bool> userLogOut() async {
    final preferences = await SharedPreferences.getInstance();
    final result = await preferences.remove('token');
    await preferences.reload();
    return result;
  }

  static Future<bool> clearAllData() async {
    final preferences = await SharedPreferences.getInstance();
    final result = await preferences.clear();
    await preferences.reload();
    return result;
  }
}
