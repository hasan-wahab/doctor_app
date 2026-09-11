import 'package:doctor_app/core/app_styles/app_colors.dart';
import 'package:doctor_app/core/app_styles/app_sizes.dart';
import 'package:doctor_app/core/app_styles/app_text_styles.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class NoInternetOverlay extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetOverlay({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.firstTextBlackColor.withValues(alpha: 0.78),
      child: Padding(
        padding: AppSizes.authInsets,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              color: AppColors.textWhiteColor,
              size: AppSizes.iconXl,
            ),
            SizedBox(height: AppSizes.spaceXl),
            CustomText(
              text: 'You are offline',
              style: AppTextStyles.name.copyWith(
                color: AppColors.textWhiteColor,
              ),
              align: TextAlign.center,
            ),
            SizedBox(height: AppSizes.spaceSm),
            CustomText(
              text: 'Playback is paused. Reconnect and we will resume for you.',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textWhiteColor,
              ),
              align: TextAlign.center,
              maxLines: 3,
              textOverflow: TextOverflow.visible,
            ),
            SizedBox(height: AppSizes.spaceXxl),
            SizedBox(
              height: AppSizes.buttonHeightSm,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.textWhiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                ),
                icon: Icon(Icons.refresh_rounded, size: AppSizes.iconSm),
                label: Text('Try again', style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
