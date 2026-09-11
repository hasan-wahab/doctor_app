import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/app_styles/app_text_styles.dart';

class QuickOverview extends StatelessWidget {
  final VoidCallback onVisitsTap;
  final VoidCallback onActivePackagesTap;
  final VoidCallback onAssessmentsTap;
  final VoidCallback onInvoiceTap;
  final VoidCallback onSessionsTap;
  final String visits;
  final String activePackages;
  final String assessments;
  final String invoice;
  final String sessions;

  const QuickOverview({
    super.key,
    this.visits = '0',
    this.activePackages = '0',
    this.assessments = '',
    this.invoice = '0',
    this.sessions = '0',
    required this.onVisitsTap,
    required this.onActivePackagesTap,
    required this.onAssessmentsTap,
    required this.onInvoiceTap,
    required this.onSessionsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _OverviewTile(
                  onTap: onVisitsTap,
                  label: 'Visits',
                  value: visits,
                  icon: Icons.calendar_month_outlined,
                ),
              ),
              SizedBox(width: AppSizes.gapMd),
              Expanded(
                child: _OverviewTile(
                  onTap: onActivePackagesTap,
                  label: 'Active Packages',
                  value: activePackages,
                  icon: Icons.inventory_2_outlined,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.spaceMd),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _OverviewTile(
                  onTap: onAssessmentsTap,
                  label: 'Assessments',
                  value: assessments,
                  icon: Icons.assignment_outlined,
                ),
              ),
              SizedBox(width: AppSizes.gapMd),
              Expanded(
                child: _OverviewTile(
                  onTap: onInvoiceTap,
                  label: 'Invoices',
                  value: invoice,
                  icon: Icons.description_outlined,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.spaceMd),
        _OverviewTile(
          onTap: onSessionsTap,
          label: 'Scheduled Sessions',
          value: sessions,
          icon: Icons.event_available_outlined,
          highlighted: true,
        ),
      ],
    );
  }
}

class _OverviewTile extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final String value;
  final IconData icon;
  final bool highlighted;

  const _OverviewTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: highlighted ? AppColors.secondaryColor : AppColors.bgColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        side: BorderSide(
          color: highlighted ? AppColors.secondaryColor : AppColors.borderColor,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.gapMd,
            vertical: AppSizes.spaceXl,
          ),
          child: Row(
            children: [
              Container(
                height: AppSizes.buttonHeightSm,
                width: AppSizes.buttonHeightSm,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: highlighted
                      ? AppColors.bgColor
                      : AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Icon(
                  icon,
                  size: AppSizes.iconMd,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(width: AppSizes.gapMd),
              Expanded(
                child: CustomText(
                  text: label,
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.labelTextColor,
                  ),
                  maxLines: 2,
                  textOverflow: TextOverflow.visible,
                ),
              ),
              if (value.isNotEmpty) ...[
                SizedBox(width: AppSizes.gapSm),
                CustomText(
                  text: value,
                  style: AppTextStyles.name,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
