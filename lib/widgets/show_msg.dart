import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_styles/app_colors.dart';

class AppMsg {
  AppMsg._();

  static showErrorMsg(
    BuildContext context, {
    required String msg,
    String? msgTitle,
    VoidCallback? action,
    VoidCallback? action2,
    String? actionText,
    String? actionText2,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msgTitle ?? 'Error',
              style: TextStyle(
                color: msgTitle != null ? AppColors.primaryColor : Colors.red,
              ),
            ),
            Spacer(),
            Icon(
              Icons.error_outline,
              color: msgTitle != null ? AppColors.primaryColor : Colors.red,
            ),
          ],
        ),
        content: Text(msg),
        backgroundColor: AppColors.secondaryColor,
        actions: [
          InkWell(
            onTap:
                action ??
                () {
                  Navigator.pop(context);
                },
            child: Text(
              actionText ?? 'OK',
              style: TextStyle(color: AppColors.linkTextColor),
            ),
          ),
          SizedBox(width: 10.w),
          actionText2 != null
              ? InkWell(
                  onTap:
                      action2 ??
                      () {
                        Navigator.pop(context);
                      },
                  child: Text(
                    actionText2,
                    style: TextStyle(color: AppColors.linkTextColor),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  static showSnackBar(BuildContext context, {required String message}) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
