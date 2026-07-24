import 'package:doctor_app/screens/assessments/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

class PatientInfoCardWidget extends StatelessWidget {
  final String? patientName;
  final String? cnic;
  final String? age;
  final String? gender;
  final String? consultant;

  const PatientInfoCardWidget({
    super.key,
    this.patientName,
    this.cnic,
    this.age,
    this.gender,
    this.consultant,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'Patient Information'),

        Card(
          color: AppColors.secondaryColor,
          margin: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('PATIENT NAME', patientName.toString()),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(child: _buildInfoRow('CNIC', cnic.toString())),
                    Expanded(
                      child: _buildInfoRow('AGE / GENDER', '$age | $gender'),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildInfoRow(
                  'CONSULTANT',
                  consultant.toString(),
                  valueColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.labelTextColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: valueColor ?? AppColors.firstTextBlackColor,
          ),
        ),
      ],
    );
  }
}
