import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_styles/app_colors.dart';
import '../../../data/models/all_consutant_assessment_model.dart';
import 'section_header.dart';

class MMTTableWidget extends StatelessWidget {
  final Map<String, List<MmtEntry>> mmt;

  const MMTTableWidget({super.key, required this.mmt});

  @override
  Widget build(BuildContext context) {
    final regions = mmt.entries.where((e) => e.value.isNotEmpty).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'MANUAL MUSCLE TESTING (MMT)'),
        if (regions.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Text(
              'No MMT data',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.labelTextColor,
              ),
            ),
          )
        else
          Column(
            children: regions.map((region) {
              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softGrayColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.r),
                          topRight: Radius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        region.key,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.labelTextColor,
                        ),
                      ),
                    ),
                    ...region.value.map(_buildMmtRow),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildMmtRow(MmtEntry entry) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.muscleMovement ?? '',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.firstTextBlackColor,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Right: ${entry.right ?? '-'}',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.firstTextBlackColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Left: ${entry.left ?? '-'}',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.firstTextBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
