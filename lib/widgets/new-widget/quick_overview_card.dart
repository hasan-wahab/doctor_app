import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';

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
                  icon: Icons.visibility_outlined,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _OverviewTile(
                  onTap: onActivePackagesTap,
                  label: 'Active packages',
                  value: activePackages,
                  icon: Icons.credit_card_outlined,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _OverviewTile(
                  onTap: onAssessmentsTap,
                  label: 'Assessments',
                  value: assessments,
                  icon: Icons.warning_amber_rounded,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _OverviewTile(
                  onTap: onInvoiceTap,
                  label: 'Invoice',
                  value: invoice,
                  icon: Icons.visibility_outlined,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        _OverviewTile(
          onTap: onSessionsTap,
          label: 'Sessions',
          value: sessions,
          icon: Icons.credit_card_outlined,
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

  const _OverviewTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColors.secondaryColor,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    if (value.isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.firstTextBlackColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(icon, size: 22.sp, color: AppColors.blackIconColor),
            ],
          ),
        ),
      ),
    );
  }
}
