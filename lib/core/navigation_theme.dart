import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_styles/app_colors.dart';

abstract final class AppSystemUi {
  AppSystemUi._();

  static SystemUiOverlayStyle light = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.bgColor,
    systemNavigationBarDividerColor: AppColors.bgColor,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarContrastEnforced: false,
  );
}
