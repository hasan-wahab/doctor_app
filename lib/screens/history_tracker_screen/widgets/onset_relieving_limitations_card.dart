import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

class OnsetRelievingLimitationsCard extends StatelessWidget {
  final String howStart;
  final List<String> possibleCause;
  final List<String> aggravatingFactors;
  final List<String> relievingFactors;
  final List<String> functionalLimitations;
  final String analysis;
  const OnsetRelievingLimitationsCard({
    super.key,
    required this.howStart,
    required this.possibleCause,
    required this.aggravatingFactors,
    required this.relievingFactors,
    required this.functionalLimitations,
    required this.analysis,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              howStart != ''
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionLabel('ONSET & CAUSE', AppColors.primaryColor),
                        SizedBox(height: 6.h),
                        Text(
                          'How did the pain start? $howStart',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.firstTextBlackColor,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Divider(height: 1.h, color: AppColors.borderColor),
                        SizedBox(height: 14.h),
                      ],
                    )
                  : SizedBox(),
              possibleCause.isEmpty
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionLabel('POSSIBLE CAUSE', AppColors.primaryColor),
                        SizedBox(height: 10.h),
                        Row(
                          children: List.generate(possibleCause.length, (
                            index,
                          ) {
                            return _iconLabel(
                              Icons.real_estate_agent_outlined,
                              possibleCause[index],
                            );
                          }),
                        ),
                        SizedBox(height: 14.h),
                        Divider(height: 1.h, color: AppColors.borderColor),
                        SizedBox(height: 14.h),
                      ],
                    ),
              relievingFactors.isEmpty
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionLabel(
                          'RELIEVING FACTORS',
                          AppColors.primaryColor,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: List.generate(relievingFactors.length, (
                            index,
                          ) {
                            return _iconLabel(
                              Icons.real_estate_agent_outlined,
                              relievingFactors[index],
                            );
                          }),
                        ),
                        SizedBox(height: 14.h),
                        Divider(height: 1.h, color: AppColors.borderColor),
                        SizedBox(height: 14.h),
                      ],
                    ),
              analysis == ''
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionLabel('Analysis', AppColors.primaryColor),
                        SizedBox(height: 6.h),
                        Text(
                          analysis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.firstTextBlackColor,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Divider(height: 1.h, color: AppColors.borderColor),
                        SizedBox(height: 14.h),
                      ],
                    ),
              functionalLimitations.isEmpty
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionLabel(
                          'FUNCTIONAL LIMITATIONS',
                          AppColors.dueRedColor,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: List.generate(
                            functionalLimitations.length,
                            (index) {
                              return _iconLabel(
                                Icons.real_estate_agent_outlined,
                                functionalLimitations[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w800,
        color: color,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _iconLabel(IconData icon, String label) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: AppColors.labelTextColor),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.firstTextBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
