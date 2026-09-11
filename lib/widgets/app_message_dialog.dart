import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_styles/app_colors.dart';
import '../core/app_styles/app_sizes.dart';
import '../core/app_styles/app_text_styles.dart';
import 'app_msg_type.dart';

class AppMessageDialog extends StatelessWidget {
  const AppMessageDialog({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.buttonLabel = 'OK',
  });

  final String title;
  final String message;
  final AppMsgType type;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
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
              color: type.color,
              child: Row(
                children: [
                  Icon(
                    type.icon,
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
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: type.color,
                  foregroundColor: AppColors.textWhiteColor,
                  elevation: 0,
                  minimumSize: Size(0, AppSizes.buttonHeightSm),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                ),
                child: Text(
                  buttonLabel,
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
    );
  }
}

Future<void> showAppMessageDialog({
  required BuildContext context,
  required String message,
  String? title,
  AppMsgType type = AppMsgType.info,
  String buttonLabel = 'OK',
  bool barrierDismissible = true,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AppMessageDialog(
      title: title ?? type.title,
      message: message,
      type: type,
      buttonLabel: buttonLabel,
    ),
  );
}
