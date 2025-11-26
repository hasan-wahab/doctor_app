import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 71.h),
            Container(
              alignment: Alignment.center,
              height: 84.h,
              width: 84.w,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                size: 40.sp,
                color: AppColors.whiteIconColor,
              ),
            ),
            SizedBox(height: 15.h),
            CustomText(text: 'Payment Successful', fontSize: 24),
            CustomText(
              text: 'Your Appointment has been \nBooked Successfully.',
              fontSize: 15,
              align: TextAlign.center,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(height: 30.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
              height: 210.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.bgColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                spacing: 20.h,
                children: [
                  Row(
                    spacing: 10.w,
                    children: [
                      Container(
                        height: 52.h,
                        width: 52.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/profile_image.png',
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: 'Dr.Smith', fontSize: 24),
                          CustomText(
                            text: 'Physiotherapist',
                            color: AppColors.secondaryTextColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 14.w,
                    children: [
                      Icon(Icons.calendar_month, size: 20.sp),
                      CustomText(text: 'Tue, Oct23 10:00-10:30 AM '),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 14.w,
                    children: [
                      Icon(Icons.wallet, size: 20.sp),
                      CustomText(text: 'Easypaisa Wallet'),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 14.w,
                    children: [
                      Icon(Icons.monetization_on, size: 20.sp),
                      CustomText(text: 'Rs. 21,00'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 36.h),
            CustomText(text: 'Account Number', fontSize: 24),
            SizedBox(height: 9.h),

            AppTField(hintText: 'APT-54832'),
            SizedBox(height: 19.h),
            AppButton(text: 'View Appointment'),
            SizedBox(height: 38.h),
            InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.naveBar,
                  (Route<dynamic> route) => false,
                );
              },
              child: CustomText(
                text: 'Go to Home',
                fontSize: 20,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 9.h),

            CustomText(
              text:
                  'Thank you for choosing Easypaisa. we\nwish you good health!',
              color: AppColors.secondaryTextColor,
              align: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
