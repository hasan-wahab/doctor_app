import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_styles/app_colors.dart';

class BookAppointmentScreen extends StatelessWidget {
  const BookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Book appointment'),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              AppTField(
                hintText: 'Search doctor or speciality',
                icon: Icon(Icons.search),
              ),
              SizedBox(height: 16.h),
              CustomText(text: 'Doctor Selection', fontSize: 20),
              SizedBox(height: 16.h),

              Column(
                spacing: 10.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 11.h,
                      left: 20.w,
                      right: 12.w,
                      bottom: 10.h,
                    ),
                    height: 137.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.primaryColor,
                      ),
                      color: AppColors.bgColor,
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
                                  color: AppColors.firstTextBlackColor,
                                ),
                                CustomText(
                                  text: 'Physiotherapist',
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                      color: AppColors.blackIconColor,
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text: 'Clinic',
                                  color: AppColors.firstTextBlackColor,
                                ),
                              ],
                            ),
                            CustomText(text: '2000 PKR'),
                            AppButton(
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.selectDateScreen,
                              ),
                              height: 40,
                              text: 'Book Appointment',
                              width: 153,
                              textSize: 13,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 11.h,
                      left: 20.w,
                      right: 12.w,
                      bottom: 10.h,
                    ),
                    height: 137.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.primaryColor,
                      ),
                      color: AppColors.bgColor,
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
                                  color: AppColors.firstTextBlackColor,
                                ),
                                CustomText(
                                  text: 'Physiotherapist',
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                      color: AppColors.blackIconColor,
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text: 'Clinic',
                                  color: AppColors.firstTextBlackColor,
                                ),
                              ],
                            ),
                            CustomText(text: '2000 PKR'),
                            AppButton(
                              height: 40,
                              text: 'Book Appointment',
                              width: 153,
                              textSize: 13,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 11.h,
                      left: 20.w,
                      right: 12.w,
                      bottom: 10.h,
                    ),
                    height: 137.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.primaryColor,
                      ),
                      color: AppColors.bgColor,
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
                                  color: AppColors.firstTextBlackColor,
                                ),
                                CustomText(
                                  text: 'Physiotherapist',
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                      color: AppColors.blackIconColor,
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text: 'Clinic',
                                  color: AppColors.firstTextBlackColor,
                                ),
                              ],
                            ),
                            CustomText(text: '2000 PKR'),
                            AppButton(
                              height: 40,
                              text: 'Book Appointment',
                              width: 153,
                              textSize: 13,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 11.h,
                      left: 20.w,
                      right: 12.w,
                      bottom: 10.h,
                    ),
                    height: 137.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.primaryColor,
                      ),
                      color: AppColors.bgColor,
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
                                  color: AppColors.firstTextBlackColor,
                                ),
                                CustomText(
                                  text: 'Physiotherapist',
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                      color: AppColors.blackIconColor,
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text: 'Clinic',
                                  color: AppColors.firstTextBlackColor,
                                ),
                              ],
                            ),
                            CustomText(text: '2000 PKR'),
                            AppButton(
                              height: 40,
                              text: 'Book Appointment',
                              width: 153,
                              textSize: 13,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 11.h,
                      left: 20.w,
                      right: 12.w,
                      bottom: 10.h,
                    ),
                    height: 137.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.primaryColor,
                      ),
                      color: AppColors.bgColor,
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
                                  color: AppColors.firstTextBlackColor,
                                ),
                                CustomText(
                                  text: 'Physiotherapist',
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                      color: AppColors.blackIconColor,
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text: 'Clinic',
                                  color: AppColors.firstTextBlackColor,
                                ),
                              ],
                            ),
                            CustomText(text: '2000 PKR'),
                            AppButton(
                              height: 40,
                              text: 'Book Appointment',
                              width: 153,
                              textSize: 13,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
