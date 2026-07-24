import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';
import 'history_taker_section_title.dart';

class RegionsInvolvedCard extends StatelessWidget {
  final List<String> regions;
  final List<String> sideAffected;
  String deviation;
  RegionsInvolvedCard({
    super.key,
    required this.regions,
    required this.sideAffected,
    required this.deviation,
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
              regions.isNotEmpty
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HistoryTakerSectionTitle(title: 'Regions Involved'),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: regions.map(_chip).toList(),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    )
                  : SizedBox.shrink(),

              sideAffected.isNotEmpty
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HistoryTakerSectionTitle(title: 'Side Affected'),
                        Wrap(
                          children: List.generate((sideAffected.length), (index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.bgColor,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(color: AppColors.borderColor),
                              ),
                              child: Text(
                                sideAffected[index],
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.labelTextColor,
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    )
                  : SizedBox.shrink(),

              deviation != ''
                  ? Column(
                      children: [
                        HistoryTakerSectionTitle(title: 'Deviation'),
                        Text(
                          deviation,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.labelTextColor,
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.softGrayColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.firstTextBlackColor,
        ),
      ),
    );
  }
}
