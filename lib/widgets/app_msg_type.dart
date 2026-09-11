import 'package:flutter/material.dart';

import '../core/app_styles/app_colors.dart';

enum AppMsgType { success, error, info, warning }

extension AppMsgTypeX on AppMsgType {
  String get title {
    switch (this) {
      case AppMsgType.success:
        return 'Success';
      case AppMsgType.error:
        return 'Error';
      case AppMsgType.info:
        return 'Info';
      case AppMsgType.warning:
        return 'Please note';
    }
  }

  Color get color {
    switch (this) {
      case AppMsgType.success:
        return AppColors.success;
      case AppMsgType.error:
        return AppColors.error;
      case AppMsgType.info:
        return AppColors.info;
      case AppMsgType.warning:
        return AppColors.warning;
    }
  }

  IconData get icon {
    switch (this) {
      case AppMsgType.success:
        return Icons.check_circle_outline_rounded;
      case AppMsgType.error:
        return Icons.error_outline_rounded;
      case AppMsgType.info:
        return Icons.info_outline_rounded;
      case AppMsgType.warning:
        return Icons.warning_amber_rounded;
    }
  }
}
