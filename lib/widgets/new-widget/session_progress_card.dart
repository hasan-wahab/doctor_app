import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';

class SessionProgressCard extends StatelessWidget {
  final String title;
  final String progressLabel;
  final int completedSessions;
  final int totalSessions;
  final String nextSessionLabel;
  final String nextSessionDate;

  const SessionProgressCard({
    super.key,
    this.title = '',
    this.progressLabel = '',
    this.completedSessions = 1,
    this.totalSessions = 1,
    this.nextSessionLabel = '',
    this.nextSessionDate = '',
  });

  double get _progress {
    if (totalSessions <= 0) return 0;
    return (completedSessions / totalSessions).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondaryColor,
      margin: EdgeInsets.only(bottom: 10.h),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.firstTextBlackColor,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  progressLabel,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.labelTextColor,
                  ),
                ),
                Text(
                  '$completedSessions/$totalSessions',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.firstTextBlackColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 4.h,
                backgroundColor: AppColors.borderColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Text(
                  nextSessionLabel,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  nextSessionDate,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
