import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';
import 'history_taker_section_title.dart';

class AggravatingMovementsCard extends StatelessWidget {
  final List<String> rows;
  const AggravatingMovementsCard({super.key,required this.rows});

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
              const HistoryTakerSectionTitle(title: 'Aggravating Movements'),
              ...rows.map(
                (e) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: _movementRow(e),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _movementRow(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.softGrayColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.firstTextBlackColor,
              ),
            ),
          ),
          Icon(
            Icons.show_chart,
            size: 18.sp,
            color: AppColors.diagnosisRedColor,
          ),
        ],
      ),
    );
  }

  Widget _tag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.softGrayColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.labelTextColor,
        ),
      ),
    );
  }
}
