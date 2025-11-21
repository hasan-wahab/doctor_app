import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllPackagesAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AllPackagesAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            color: AppColors.secondaryColor,
            height: 125.h,
            child: Row(
              spacing: 20.w,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 30,
                    color: AppColors.primaryColor,
                  ),
                ),
                CustomText(
                  text: 'Therapy Search & Booking In',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.firstTextBlackColor,
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 54.h,
            width: 350.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 7,
                  spreadRadius: 1,
                  offset: Offset(0, 4),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 5.w,
              children: [
                SizedBox(width: 15.w),
                Icon(Icons.search, size: 30.sp, color: AppColors.primaryColor),
                CustomText(
                  text: 'Search here',
                  color: AppColors.secondaryTextColor,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(110.h);
}
