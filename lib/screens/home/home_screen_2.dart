import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
        children: [
          SizedBox(height: 80.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 58.h,
                    width: 58.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/profile_image.png'),
                      ),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Hi, Hamza', fontSize: 20),
                      CustomText(
                        text: '15 October,2025',
                        fontSize: 12,
                        color: AppColors.secondaryTextColor,
                      ),
                    ],
                  ),
                ],
              ),

              Stack(
                alignment: Alignment.topRight,
                children: [
                  CircleAvatar(
                    child: Icon(
                      CupertinoIcons.bell,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  Container(
                    height: 10.h,
                    width: 10.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 57.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            height: 145.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Balance',
                  fontSize: 20,
                  color: AppColors.textWhiteColor,
                ),

                CustomText(
                  text: 'PKR 3000.00',
                  fontSize: 32,
                  color: AppColors.textWhiteColor,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.walletScreen);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 31.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AppColors.secondaryColor,
                        ),
                        child: CustomText(
                          text: 'Recharge',
                          fontSize: 20,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 50.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.bookAppointmentScreen,
                ),
                child: Container(
                  height: 96.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.secondaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.calendar_badge_plus,
                        size: 36.sp,
                        color: AppColors.primaryColor,
                      ),
                      CustomText(
                        text: 'Book Appointment',
                        maxLines: 2,
                        align: TextAlign.center,
                        color: AppColors.secondaryTextColor,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 96.h,
                width: 110.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.secondaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.clock_fill,
                      size: 36.sp,
                      color: AppColors.primaryColor,
                    ),
                    CustomText(
                      text: 'Previous Treatment',
                      maxLines: 2,
                      align: TextAlign.center,
                      color: AppColors.secondaryTextColor,
                    ),
                  ],
                ),
              ),
              Container(
                height: 96.h,
                width: 110.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.secondaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.person_alt_circle_fill,
                      size: 36.sp,
                      color: AppColors.primaryColor,
                    ),
                    CustomText(
                      text: 'Update\nProfile',
                      maxLines: 2,
                      align: TextAlign.center,
                      color: AppColors.secondaryTextColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 37.h),

          CustomText(text: 'Upcoming Session'),
          SizedBox(height: 28.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            height: 98.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 46.h,
                      width: 46.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/profile_image.png'),
                        ),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 2.w,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'DR.Smith',
                          fontSize: 20,
                          color: AppColors.textWhiteColor,
                        ),
                        CustomText(
                          text: '15 October,2025 10:00 AM',
                          fontSize: 12,
                          color: AppColors.secondaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.appointmentDetailScreen,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 28.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AppColors.secondaryColor,
                        ),
                        child: CustomText(
                          text: 'View Detail',
                          fontSize: 12,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
