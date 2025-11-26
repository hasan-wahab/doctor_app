import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_routes/routes_name.dart';
import '../../app_styles/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/custom_text.dart';

class ConfirmAppointmentScreen extends StatelessWidget {
  const ConfirmAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Confirm Appointment'),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(height: 20.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 92.h,
                      width: 92.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/profile_image.png'),
                        ),
                        color: AppColors.firstTextBlackColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    CustomText(text: 'Dr.Smith', fontSize: 28),
                    CustomText(
                      text: 'Speciality',
                      color: AppColors.secondaryTextColor,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 35.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [CustomText(text: 'Appointment info', fontSize: 20)],
            ),
            SizedBox(height: 22.h),
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
                CustomText(text: '10:00 AM - 10:30 AM', fontSize: 16),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Session Duration', fontSize: 18),
                CustomText(text: '30 minutes', fontSize: 16),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Consultation Mode', fontSize: 18),
                CustomText(text: 'Online / In-Person', fontSize: 16),
              ],
            ),
            SizedBox(height: 41.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [CustomText(text: 'Fee Details', fontSize: 20)],
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Consultation Fee', fontSize: 18),
                CustomText(text: 'PKR 2000', fontSize: 16),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Service Charges', fontSize: 18),
                CustomText(text: 'PKR 100', fontSize: 16),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Total', fontSize: 18),
                CustomText(text: 'PKR 2,100', fontSize: 16),
              ],
            ),
            SizedBox(height: 68.h),

            AppButton(
              text: 'Continue',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.paymentOptionScreen);
              },
            ),
            SizedBox(height: 12.h),
            CustomText(text: 'Edit', color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
