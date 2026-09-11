import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../core/app_styles/app_colors.dart';
import '../core/app_styles/app_sizes.dart';
import '../core/app_styles/app_text_styles.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.folder_off_outlined,
    this.onRetry,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onRetry;

  static bool isOffline(String? message) {
    final text = (message ?? '').toLowerCase();
    return text.contains('no internet');
  }

  factory AppEmptyState.offline({Key? key, VoidCallback? onRetry}) {
    return AppEmptyState(
      key: key,
      icon: Icons.wifi_off_outlined,
      title: 'No internet connection',
      subtitle: 'Connect to the internet and try again.',
      onRetry: onRetry,
    );
  }

  factory AppEmptyState.historyTracker({
    Key? key,
    String? message,
    VoidCallback? onRetry,
  }) {
    if (isOffline(message)) {
      return AppEmptyState.offline(key: key, onRetry: onRetry);
    }
    return AppEmptyState(
      key: key,
      icon: Icons.assignment_outlined,
      title: 'No history tracker found',
      subtitle:
          'History taking has not been recorded for this visit yet.',
      onRetry: onRetry,
    );
  }

  factory AppEmptyState.consultant({
    Key? key,
    String? message,
    VoidCallback? onRetry,
  }) {
    if (isOffline(message)) {
      return AppEmptyState.offline(key: key, onRetry: onRetry);
    }
    return AppEmptyState(
      key: key,
      icon: Icons.medical_information_outlined,
      title: 'No consultant assessment found',
      subtitle:
          'A consultant assessment has not been added for this visit yet.',
      onRetry: onRetry,
    );
  }

  factory AppEmptyState.therapySession({
    Key? key,
    String? message,
    VoidCallback? onRetry,
  }) {
    if (isOffline(message)) {
      return AppEmptyState.offline(key: key, onRetry: onRetry);
    }
    return AppEmptyState(
      key: key,
      icon: Icons.spa_outlined,
      title: 'No therapy session found',
      subtitle:
          'No therapy session has been recorded for this visit yet.',
      onRetry: onRetry,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSizes.pageInsets,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: AppSizes.buttonHeight,
              width: AppSizes.buttonHeight,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: AppSizes.iconLg,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: AppSizes.spaceXxl),
            CustomText(
              text: title,
              align: TextAlign.center,
              maxLines: 2,
              style: AppTextStyles.name,
            ),
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              SizedBox(height: AppSizes.spaceSm),
              CustomText(
                text: subtitle!,
                align: TextAlign.center,
                maxLines: 4,
                textOverflow: TextOverflow.visible,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.mutedTextColor,
                ),
              ),
            ],
            if (onRetry != null) ...[
              SizedBox(height: AppSizes.spaceXxl),
              Material(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                child: InkWell(
                  onTap: onRetry,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.gapLg,
                      vertical: AppSizes.spaceSm,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.refresh_rounded,
                          size: AppSizes.iconSm,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: AppSizes.gapSm),
                        CustomText(
                          text: 'Try again',
                          style: AppTextStyles.chipPrimary.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AppEmptyRefreshView extends StatelessWidget {
  const AppEmptyRefreshView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : AppSizes.buttonHeight * 8;
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: height, child: child),
          ],
        );
      },
    );
  }
}
