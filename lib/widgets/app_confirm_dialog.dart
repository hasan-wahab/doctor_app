import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_styles/app_colors.dart';
import '../core/app_styles/app_sizes.dart';
import '../core/app_styles/app_text_styles.dart';

class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.help_outline_rounded,
    this.headerColor,
    this.cancelLabel = 'No',
    this.confirmLabel = 'Yes',
    this.cancelColor,
    this.confirmColor,
  });

  final String title;
  final String message;
  final IconData icon;
  final Color? headerColor;
  final String cancelLabel;
  final String confirmLabel;
  final Color? cancelColor;
  final Color? confirmColor;

  @override
  Widget build(BuildContext context) {
    final header = headerColor ?? AppColors.primaryColor;
    final cancel = cancelColor ?? AppColors.secondaryButton;
    final confirm = confirmColor ?? AppColors.primaryColor;

    return Dialog(
      backgroundColor: AppColors.bgColor,
      insetPadding: AppSizes.authInsets,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                AppSizes.gapMd,
                AppSizes.spaceLg,
                AppSizes.gapMd,
                AppSizes.spaceLg,
              ),
              color: header,
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: AppSizes.iconSm,
                    color: AppColors.textWhiteColor,
                  ),
                  SizedBox(width: AppSizes.gapSm),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textWhiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSizes.gapLg,
                AppSizes.spaceXl,
                AppSizes.gapLg,
                AppSizes.spaceSm,
              ),
              child: Text(
                message,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.firstTextBlackColor,
                  height: 1.4,
                ),
              ),
            ),
            Divider(height: 1.h, thickness: 1, color: AppColors.borderColor),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSizes.gapMd,
                AppSizes.spaceMd,
                AppSizes.gapMd,
                AppSizes.spaceLg,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: TextButton.styleFrom(
                        backgroundColor: cancel,
                        foregroundColor: AppColors.textWhiteColor,
                        minimumSize: Size(0, AppSizes.buttonHeightSm),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                        ),
                      ),
                      child: Text(
                        cancelLabel,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textWhiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSizes.gapSm),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: confirm,
                        foregroundColor: AppColors.textWhiteColor,
                        elevation: 0,
                        minimumSize: Size(0, AppSizes.buttonHeightSm),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                        ),
                      ),
                      child: Text(
                        confirmLabel,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textWhiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> showAppConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  IconData icon = Icons.help_outline_rounded,
  Color? headerColor,
  String cancelLabel = 'No',
  String confirmLabel = 'Yes',
  Color? cancelColor,
  Color? confirmColor,
  bool barrierDismissible = true,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AppConfirmDialog(
      title: title,
      message: message,
      icon: icon,
      headerColor: headerColor,
      cancelLabel: cancelLabel,
      confirmLabel: confirmLabel,
      cancelColor: cancelColor,
      confirmColor: confirmColor,
    ),
  );
  return result == true;
}
