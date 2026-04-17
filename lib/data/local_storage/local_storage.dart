import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  static Future<bool> saveUserToken(String tokenValue) async {
    final preferences = await SharedPreferences.getInstance();
    final prefs = await preferences.setString('token', tokenValue);
    return prefs;
  }

  static Future<String?> getUserToken(String key) async {
    final preferences = await SharedPreferences.getInstance();

    final prefs = await preferences.getString(key);
    return prefs;
  }

  static Future<bool> userLogOutToken() async {
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

  static Future<bool> saveProfileData(String dataKey, data) async {
    final prefs = await SharedPreferences.getInstance();

    return await prefs.setString(dataKey, data);
  }

  static Future<String?> getProfileData(String dataKey) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(dataKey);
  }
}
