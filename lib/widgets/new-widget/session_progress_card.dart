import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/app_styles/app_text_styles.dart';

class SessionProgressCard extends StatelessWidget {
  final String title;
  final String progressLabel;
  final int completedSessions;
  final int totalSessions;
  final String nextSessionLabel;
  final String nextSessionDate;

  const SessionProgressCard({
    super.key,
    this.title = '',
    this.progressLabel = '',
    this.completedSessions = 1,
    this.totalSessions = 1,
    this.nextSessionLabel = '',
    this.nextSessionDate = '',
  });

  double get _progress {
    if (totalSessions <= 0) return 0;
    return (completedSessions / totalSessions).clamp(0.0, 1.0);
  }

  bool get _isCompleted =>
      nextSessionLabel == 'Completed' || completedSessions == totalSessions;

  @override
  Widget build(BuildContext context) {
    final showNextSession = !_isCompleted &&
        nextSessionLabel.isNotEmpty &&
        nextSessionDate.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.spaceMd),
      child: Material(
        color: AppColors.bgColor,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          side: BorderSide(color: AppColors.borderColor),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSizes.gapMd,
            AppSizes.spaceLg,
            AppSizes.gapMd,
            AppSizes.spaceLg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: title,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      textOverflow: TextOverflow.visible,
                    ),
                  ),
                  SizedBox(width: AppSizes.gapSm),
                  _StatusChip(completed: _isCompleted),
                ],
              ),
              SizedBox(height: AppSizes.spaceMd),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: progressLabel,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.labelTextColor,
                    ),
                  ),
                  CustomText(
                    text: '$completedSessions/$totalSessions',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.firstTextBlackColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.spaceSm),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: AppSizes.spaceXs,
                  backgroundColor: AppColors.secondaryColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryColor,
                  ),
                ),
              ),
              if (showNextSession) ...[
                SizedBox(height: AppSizes.spaceMd),
                CustomText(
                  text: '$nextSessionLabel $nextSessionDate'.trim(),
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.completed});

  final bool completed;

  @override
  Widget build(BuildContext context) {
    final color = completed ? AppColors.success : AppColors.primaryColor;
    final bg = completed
        ? AppColors.success.withValues(alpha: 0.12)
        : AppColors.secondaryColor;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.gapMd,
        vertical: AppSizes.spaceXs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: CustomText(
        text: completed ? 'Completed' : 'In Progress',
        style: AppTextStyles.chipPrimary.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
