import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetUtils {
  static const Duration lookupTimeout = Duration(seconds: 3);

  /// Check network interface (WiFi / Mobile Data toggle).
  static Future<bool> isConnected() async {
    final results = await Connectivity().checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }

  /// Real internet check with timeout — avoids hanging when data is on but no SIM.
  static Future<bool> hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup(
        'clients3.google.com',
        type: InternetAddressType.any,
      ).timeout(lookupTimeout);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Network interface + real internet (use before playing videos).
  static Future<bool> isInternetAvailable() async {
    if (!await isConnected()) return false;
    return hasInternetAccess();
  }
}
