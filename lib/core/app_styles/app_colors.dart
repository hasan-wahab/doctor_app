
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Primary Color (use this for all greens / brand accents)
  static Color primaryColor = const Color.fromRGBO(7, 169, 150, 1);

  /// Secondary Color (light primary tint)
  static Color secondaryColor = const Color.fromRGBO(231, 242, 241, 1);

  /// Background Color
  static Color bgColor = Colors.white;

  /// Screen / page soft background
  static Color screenBgColor = const Color(0xFFF8F9FA);

  /// Card soft section background
  static Color sectionBgColor = const Color(0xFFF2F2F2);

  /// Soft gray chip / table header background
  static Color softGrayColor = const Color(0xFFF5F5F5);

  /// Text Black Color
  static Color firstTextBlackColor = Colors.black;

  /// Secondary Text Color
  static Color secondaryTextColor = const Color.fromRGBO(0, 0, 0, 0.5);

  /// Label / muted text (CNIC, AGE, TOTAL DUE, etc.)
  static Color labelTextColor = const Color(0xFF757575);

  /// Date / muted secondary text
  static Color mutedTextColor = const Color(0xFF9E9E9E);

  /// Third Text Color
  static Color textWhiteColor = Colors.white;

  /// Black Icon Color
  static Color blackIconColor = Colors.black;

  /// White Icon Color
  static Color whiteIconColor = Colors.white;

  /// Link Text Color
  static Color linkTextColor = const Color.fromRGBO(16, 70, 188, 1);

  /// Border / divider
  static Color borderColor = const Color(0xFFE0E0E0);

  /// Due / remaining / danger amount
  static Color dueRedColor = const Color(0xFFA60000);

  /// Diagnosis / solid red badge (ACL TEAR, etc.)
  static Color diagnosisRedColor = const Color(0xFFD32F2F);

  /// Soft red badge background (Abnormal, Pain chip, Neg)
  static Color softRedBgColor = const Color(0xFFFFEBEE);

  /// Soft red badge text
  static Color softRedTextColor = const Color(0xFFB71C1C);

  /// Discount / blue-gray value text
  static Color blueGrayTextColor = const Color(0xFF546E7A);

  /// Blue-gray soft chip background (Tightness)
  static Color blueGrayBgColor = const Color(0xFFECEFF1);

  /// Consultation badge background
  static Color consultationBadgeBg = const Color(0xFFF0F0F5);

  /// Consultation badge text
  static Color consultationBadgeText = const Color(0xFF6E7191);

  /// Swelling chip
  static Color swellingBlueColor = const Color(0xFF1976D2);
  static Color swellingBlueBgColor = const Color(0xFFE3F2FD);

  /// Weakness chip
  static Color weaknessPurpleColor = const Color(0xFF7B1FA2);
  static Color weaknessPurpleBgColor = const Color(0xFFF3E5F5);

  /// Assigned packages / dark card
  static Color darkCardColor = const Color(0xFF212121);

  /// Dark card secondary text (STANDARD DURATION)
  static Color darkCardMutedText = const Color(0xFFBDBDBD);
}