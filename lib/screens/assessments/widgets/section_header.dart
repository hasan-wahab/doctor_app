import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  const SectionHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w800,
          color: AppColors.labelTextColor,
        ),
      ),
    );
  }
}
