import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

class HistoryTakerPatientHeader extends StatelessWidget {
  final String patientName;
  final String age;
  final String visitId;
  final String occupation;
  const HistoryTakerPatientHeader({
    super.key,
    this.patientName = '',
    this.age = '',
    this.visitId = '',
    this.occupation = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  patientName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.firstTextBlackColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'HISTORY TAKER',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textWhiteColor,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            '$age years • Visit ID: $visitId',
            style: TextStyle(fontSize: 12.sp, color: AppColors.mutedTextColor),
          ),
          SizedBox(height: 14.h),
          Divider(height: 1.h, color: AppColors.borderColor),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                Icons.sensor_occupied,
                size: 16.sp,
                color: AppColors.mutedTextColor,
              ),
              SizedBox(width: 8.w),
              Text(
                'Occupation: $occupation',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.labelTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
