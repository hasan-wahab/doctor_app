import 'package:flutter/material.dart';

import '../core/app_styles/app_colors.dart';
import '../core/app_styles/app_sizes.dart';
import '../core/app_styles/app_text_styles.dart';
import 'app_msg_type.dart';

class AppSnackbar {
  AppSnackbar._();

  static void success(BuildContext context, String message) {
    show(context, message: message, type: AppMsgType.success);
  }

  static void error(
    BuildContext context,
    String message, {
    String title = 'Error',
  }) {
    show(context, message: message, title: title, type: AppMsgType.error);
  }

  static void info(BuildContext context, String message) {
    show(context, message: message, type: AppMsgType.info);
  }

  static void warning(BuildContext context, String message) {
    show(context, message: message, type: AppMsgType.warning);
  }

  static void show(
    BuildContext context, {
    required String message,
    String? title,
    AppMsgType type = AppMsgType.info,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? type.title,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textWhiteColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: AppSizes.spaceXs),
            Text(
              message,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textWhiteColor,
              ),
            ),
          ],
        ),
        backgroundColor: type.color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
