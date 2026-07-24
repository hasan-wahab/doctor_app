import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';
import 'history_taker_section_title.dart';

class ChiefComplaintsCard extends StatelessWidget {
  final List<String> chiefComplaints;
  final String deviation;
  final List<String> sideAffected;
  const ChiefComplaintsCard({
    super.key,
    required this.chiefComplaints,
    required this.deviation,
    required this.sideAffected,
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
              chiefComplaints.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HistoryTakerSectionTitle(title: 'Chief Complaints'),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: List.generate((chiefComplaints.length), (
                            index,
                          ) {
                            return _complaintChip(
                              chiefComplaints[index],
                              Icons.warning_amber_rounded,
                              AppColors.softRedBgColor,
                              AppColors.softRedTextColor,
                            );
                          }),
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
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: List.generate((sideAffected.length), (index) {
                            return _complaintChip(
                              sideAffected[index],
                              Icons.warning_amber_rounded,
                              AppColors.softRedBgColor,
                              AppColors.softRedTextColor,
                            );
                          }),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    )
                  : SizedBox.shrink(),

              deviation != ''
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HistoryTakerSectionTitle(title: 'Deviation'),
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

  Widget _complaintChip(String label, IconData icon, Color bg, Color fg) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: fg),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
