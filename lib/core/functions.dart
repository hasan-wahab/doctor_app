import 'dart:io';

/// NFC card is Android-only. Never show it on iPhone / iOS.
bool get showNfcCard => Platform.isAndroid;

double getSessionProgress({
  required final totalSession,
  required final usedSession,
}) {
  if (double.parse(totalSession) == 0) return 0.0;

  final progress = double.parse(usedSession) / double.parse(totalSession);

  if (progress.isNaN || progress.isInfinite) return 0.0;

  return progress.clamp(0.0, 1.0);
}

String getFirstTwoInitials(String name) {
  if (name.trim().isEmpty) return "";

  List<String> parts = name
      .trim()
      .split(" ")
      .where((e) => e.isNotEmpty)
      .toList();

  if (parts.length == 1) {
    return parts[0][0].toUpperCase();
  }

  return (parts[0][0] + parts[1][0]).toUpperCase();
}
