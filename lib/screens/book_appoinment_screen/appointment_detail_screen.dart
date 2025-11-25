import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentDetailScreen extends StatelessWidget {
  const AppointmentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: 'Appointment Details', fontSize: 24),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w),
                  height: 137.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 58.h,
                            width: 58.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/profile_image.png',
                                ),
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
                                text: 'Dr.Smith',
                                fontSize: 20,
                                color: AppColors.textWhiteColor,
                              ),
                              CustomText(
                                text: 'Physiotherapist',
                                fontSize: 12,
                                color: AppColors.secondaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 14.h,
                                color: Colors.yellow,
                              ),
                              CustomText(
                                text: '4.8',
                                fontSize: 12,
                                color: AppColors.textWhiteColor,
                              ),
                            ],
                          ),
                          CustomText(
                            text: 'Clinic',
                            color: AppColors.textWhiteColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 31.h),
            CustomText(text: 'Appointment info', fontSize: 20),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Date', fontSize: 18),
                CustomText(text: '20 Oct 2025', fontSize: 16),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Time', fontSize: 18),
                CustomText(text: '10:00 AM', fontSize: 16),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Status', fontSize: 18),
                CustomText(text: 'Confirmed', fontSize: 16),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Mode', fontSize: 18),
                Container(
                  alignment: Alignment.center,
                  height: 27.h,
                  width: 66.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: CustomText(
                    text: 'Mode',
                    fontSize: 16,
                    color: AppColors.textWhiteColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 31.h),
            CustomText(text: 'Patient Info', fontSize: 24),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Name', fontSize: 18),
                CustomText(text: 'Hamza', fontSize: 16),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Age', fontSize: 18),
                CustomText(text: '29', fontSize: 16),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Gender', fontSize: 18),
                CustomText(text: 'Male', fontSize: 16),
              ],
            ),
            SizedBox(height: 31.h),

            CustomText(text: 'Treatment', fontSize: 24),
            CustomText(
              text: 'Pain in right shoulder, follow-up required',
              fontSize: 15,
            ),
            SizedBox(height: 42.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(text: 'Reschedule', isColor: false, width: 170.w),
                AppButton(
                  textColor: Colors.red,
                  text: 'Cancel',
                  isColor: false,
                  width: 170.w,
                  borderColor: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
