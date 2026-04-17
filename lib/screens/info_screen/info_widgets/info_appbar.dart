import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';
import '../../../widgets/custom_text.dart';

class AboutTheropyAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AboutTheropyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,

      color: AppColors.secondaryColor,

      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Row(
            spacing: 20.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: 'About Ali Therapy',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.firstTextBlackColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100.h);
}