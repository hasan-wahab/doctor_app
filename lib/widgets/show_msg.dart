import 'package:flutter/material.dart';

import 'app_confirm_dialog.dart';
import 'app_message_dialog.dart';
import 'app_msg_type.dart';
import 'app_snackbar.dart';

export 'app_confirm_dialog.dart';
export 'app_message_dialog.dart';
export 'app_msg_type.dart';
export 'app_snackbar.dart';

class AppMsg {
  AppMsg._();

  /// One-button typed dialog (success / error / info / warning).
  static Future<void> show(
    BuildContext context, {
    required String message,
    String? title,
    AppMsgType type = AppMsgType.info,
    String buttonLabel = 'OK',
  }) {
    return showAppMessageDialog(
      context: context,
      message: message,
      title: title,
      type: type,
      buttonLabel: buttonLabel,
    );
  }

  /// Two-button confirm dialog. Returns `true` only when confirm is pressed.
  static Future<bool> confirm(
    BuildContext context, {
    required String message,
    String title = 'Confirm',
    String cancelLabel = 'No',
    String confirmLabel = 'Yes',
    IconData icon = Icons.help_outline_rounded,
    Color? headerColor,
    Color? confirmColor,
  }) {
    return showAppConfirmDialog(
      context: context,
      title: title,
      message: message,
      cancelLabel: cancelLabel,
      confirmLabel: confirmLabel,
      icon: icon,
      headerColor: headerColor,
      confirmColor: confirmColor,
    );
  }

  static void snack(
    BuildContext context, {
    required String message,
    String? title,
    AppMsgType type = AppMsgType.info,
  }) {
    AppSnackbar.show(
      context,
      message: message,
      title: title,
      type: type,
    );
  }

  static void success(BuildContext context, String message) {
    AppSnackbar.success(context, message);
  }

  static void error(BuildContext context, String message, {String? title}) {
    AppSnackbar.error(context, message, title: title ?? 'Error');
  }

  static void info(BuildContext context, String message) {
    AppSnackbar.info(context, message);
  }

  static void warning(BuildContext context, String message) {
    AppSnackbar.warning(context, message);
  }

  static void showSnackBar(BuildContext context, {required String message}) {
    snack(context, message: message, type: _guessType(message));
  }

  static Future<void> showErrorMsg(
    BuildContext context, {
    required String msg,
    String? msgTitle,
    VoidCallback? action,
    VoidCallback? action2,
    String? actionText,
    String? actionText2,
  }) async {
    if (actionText2 != null) {
      final ok = await confirm(
        context,
        title: msgTitle ?? 'Confirm',
        message: msg,
        cancelLabel: actionText ?? 'No',
        confirmLabel: actionText2,
      );
      if (ok) action2?.call();
      return;
    }

    await show(
      context,
      title: msgTitle,
      message: msg,
      type: AppMsgType.error,
      buttonLabel: actionText ?? 'OK',
    );
    action?.call();
  }

  static AppMsgType _guessType(String message) {
    final text = message.toLowerCase();
    if (text.contains('internet') ||
        text.contains('offline') ||
        text.contains('log in') ||
        text.contains('login') ||
        text.contains('sign in')) {
      return AppMsgType.warning;
    }
    if (text.contains('success')) return AppMsgType.success;
    if (text.contains('error') ||
        text.contains('fail') ||
        text.contains('invalid') ||
        text.contains('wrong') ||
        text.contains('incorrect')) {
      return AppMsgType.error;
    }
    return AppMsgType.info;
  }
}
