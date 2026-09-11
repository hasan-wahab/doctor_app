import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  /// ScreenUtil can return 0 while Android viewport is still 0×0.
  /// TextField crashes if fontSize is not greater than 0.
  static double _sp(double size) {
    final scaled = size.sp;
    return scaled > 0 ? scaled : size;
  }

  static TextStyle get heading1 => TextStyle(
        fontSize: _sp(28),
        fontWeight: FontWeight.bold,
        color: AppColors.firstTextBlackColor,
        height: 1.3,
      );

  static TextStyle get heading2 => TextStyle(
        fontSize: _sp(22),
        fontWeight: FontWeight.w700,
        color: AppColors.firstTextBlackColor,
        height: 1.3,
      );

  static TextStyle get heading3 => TextStyle(
        fontSize: _sp(18),
        fontWeight: FontWeight.w600,
        color: AppColors.firstTextBlackColor,
        height: 1.3,
      );

  static TextStyle get bodyLarge => TextStyle(
        fontSize: _sp(16),
        fontWeight: FontWeight.w400,
        color: AppColors.firstTextBlackColor,
        height: 1.5,
      );

  static TextStyle get body => TextStyle(
        fontSize: _sp(14),
        fontWeight: FontWeight.w400,
        color: AppColors.firstTextBlackColor,
        height: 1.5,
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: _sp(12),
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryTextColor,
        height: 1.4,
      );

  static TextStyle get label => TextStyle(
        fontSize: _sp(12),
        fontWeight: FontWeight.w500,
        color: AppColors.mutedTextColor,
        letterSpacing: 0.2,
      );

  static TextStyle get button => TextStyle(
        fontSize: _sp(16),
        fontWeight: FontWeight.w600,
        color: AppColors.textWhiteColor,
        letterSpacing: 0.3,
      );

  static TextStyle get link => TextStyle(
        fontSize: _sp(14),
        fontWeight: FontWeight.w500,
        color: AppColors.info,
        decoration: TextDecoration.underline,
      );

  static TextStyle get appBarTitle => TextStyle(
        fontSize: _sp(18),
        fontWeight: FontWeight.w700,
        color: AppColors.primaryColor,
      );

  static TextStyle get name => TextStyle(
        fontSize: _sp(16),
        fontWeight: FontWeight.w700,
        color: AppColors.firstTextBlackColor,
        letterSpacing: 0.2,
      );

  static TextStyle get chipPrimary => TextStyle(
        fontSize: _sp(12),
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor,
      );

  static TextStyle get chipMuted => TextStyle(
        fontSize: _sp(12),
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryTextColor,
      );
}
