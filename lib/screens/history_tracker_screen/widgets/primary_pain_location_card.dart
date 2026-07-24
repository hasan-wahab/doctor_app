import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

class PrimaryPainLocationCard extends StatelessWidget {
  final List<String> painLocation;

  PrimaryPainLocationCard({super.key, required this.painLocation});

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
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: AppColors.primaryColor.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 5.w,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 20.sp,
                    color: AppColors.primaryColor,
                  ),

                  Text(
                    'PRIMARY PAIN LOCATION',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              Wrap(
                children: List.generate((painLocation.length), (index) {
                  return Text(
                    painLocation[index],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryColor,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
