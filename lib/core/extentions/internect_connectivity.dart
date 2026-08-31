import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class InternetUtils {
  static const Duration timeout = Duration(seconds: 3);

  /// Check network interface (connectivity_plus 7+ returns a List).
  static Future<bool> isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return result.any((r) => r != ConnectivityResult.none);
  }

  /// Real internet check using HTTP
  static Future<bool> hasInternetAccess() async {
    try {
      final response = await http
          .get(Uri.parse('https://clients3.google.com/generate_204'))
          .timeout(timeout);

      return response.statusCode == 204;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Final check
  static Future<bool> isInternetAvailable() async {
    if (!await isConnected()) return false;
    return await hasInternetAccess();
  }
}
