import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_styles/app_colors.dart';
import 'section_header.dart';

class SessionSettingsWidget extends StatelessWidget {
  final String? duration;
  const SessionSettingsWidget({super.key, this.duration});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'SESSION SETTINGS'),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.sectionBgColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PRESCRIBED SESSION DURATION',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.labelTextColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                duration.toString(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.firstTextBlackColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
