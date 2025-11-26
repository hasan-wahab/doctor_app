import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectDateScreen extends StatelessWidget {
  const SelectDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select Date'),
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
                  //co
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
            SizedBox(height: 24.h),
            Container(
              height: 400.h,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  CalendarDatePicker(
                    currentDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                    onDateChanged: (value) {},
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 33.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: CustomText(
                            text: '9:00 AM',
                            color: AppColors.textWhiteColor,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 33.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: CustomText(
                            text: '10:00 AM',
                            color: AppColors.textWhiteColor,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 33.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: CustomText(
                            text: '10:30 AM',
                            color: AppColors.textWhiteColor,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 33.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: CustomText(
                            text: '3:00 PM',
                            color: AppColors.textWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 51.h),
            AppButton(
              text: 'Continue',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.confirmAppointment);
              },
            ),
          ],
        ),
      ),
    );
  }
}
