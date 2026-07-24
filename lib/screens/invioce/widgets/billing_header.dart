import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

class BillingHeader extends StatelessWidget {
  const BillingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4.w,
          height: 48.h,
          margin: EdgeInsets.only(top: 2.h, right: 10.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Billing History',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.firstTextBlackColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Manage and track your medical invoices',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.labelTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
