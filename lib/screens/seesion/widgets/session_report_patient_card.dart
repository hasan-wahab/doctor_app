import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

class SessionReportPatientCard extends StatelessWidget {
  final String patientName;
  final String cnic;
  final String gender;
  final String attendingTherapist;

  const SessionReportPatientCard({
    super.key,
    required this.patientName,
    required this.cnic,
    required this.gender,
    required this.attendingTherapist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PATIENT INFORMATION',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.primaryColor,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 14.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _field('NAME', patientName)),
            SizedBox(width: 12.w),
            Expanded(child: _field('CNIC', cnic)),
          ],
        ),
        SizedBox(height: 14.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _field('GENDER', gender)),
            SizedBox(width: 12.w),
            Expanded(child: _field('THERAPIST', attendingTherapist.toUpperCase())),
          ],
        ),
      ],
    );
  }

  Widget _field(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.labelTextColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.firstTextBlackColor,
          ),
        ),
      ],
    );
  }
}
