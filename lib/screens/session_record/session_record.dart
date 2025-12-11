import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_routes/routes_name.dart';
import '../../app_styles/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/custom_text.dart';

class SessionRecord extends StatelessWidget {
  const SessionRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Session Records'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            spacing: 10.h,
            children: [
              SizedBox(height: 23.h),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: 11.h,
                  left: 20.w,
                  right: 12.w,
                  bottom: 10.h,
                ),
                height: 143.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.primaryColor),
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Oct 15,2025 - 9:00AM',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                            CustomText(
                              text: 'Cognitive Therapy',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                          ],
                        ),

                        AppButton(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.notesScreen,
                          ),
                          height: 33,
                          text: 'Notes',
                          width: 96,
                          textSize: 13,
                          isColor: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: 11.h,
                  left: 20.w,
                  right: 12.w,
                  bottom: 10.h,
                ),
                height: 143.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.primaryColor),
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Oct 15,2025 - 9:00AM',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                            CustomText(
                              text: 'Cognitive Therapy',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                          ],
                        ),

                        AppButton(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.notesScreen,
                          ),
                          height: 33,
                          text: 'Notes',
                          width: 96,
                          textSize: 13,
                          isColor: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: 11.h,
                  left: 20.w,
                  right: 12.w,
                  bottom: 10.h,
                ),
                height: 143.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.primaryColor),
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Oct 15,2025 - 9:00AM',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                            CustomText(
                              text: 'Cognitive Therapy',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                          ],
                        ),

                        AppButton(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.notesScreen,
                          ),
                          height: 33,
                          text: 'Notes',
                          width: 96,
                          textSize: 13,
                          isColor: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: 11.h,
                  left: 20.w,
                  right: 12.w,
                  bottom: 10.h,
                ),
                height: 143.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.primaryColor),
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Oct 15,2025 - 9:00AM',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                            CustomText(
                              text: 'Cognitive Therapy',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                          ],
                        ),

                        AppButton(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.notesScreen,
                          ),
                          height: 33,
                          text: 'Notes',
                          width: 96,
                          textSize: 13,
                          isColor: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: 11.h,
                  left: 20.w,
                  right: 12.w,
                  bottom: 10.h,
                ),
                height: 143.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.primaryColor),
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Oct 15,2025 - 9:00AM',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                            CustomText(
                              text: 'Cognitive Therapy',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                          ],
                        ),

                        AppButton(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.notesScreen,
                          ),
                          height: 33,
                          text: 'Notes',
                          width: 96,
                          textSize: 13,
                          isColor: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: 11.h,
                  left: 20.w,
                  right: 12.w,
                  bottom: 10.h,
                ),
                height: 143.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.primaryColor),
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Oct 15,2025 - 9:00AM',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                            CustomText(
                              text: 'Cognitive Therapy',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                          ],
                        ),

                        AppButton(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.notesScreen,
                          ),
                          height: 33,
                          text: 'Notes',
                          width: 96,
                          textSize: 13,
                          isColor: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: 11.h,
                  left: 20.w,
                  right: 12.w,
                  bottom: 10.h,
                ),
                height: 143.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.primaryColor),
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Oct 15,2025 - 9:00AM',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                            CustomText(
                              text: 'Cognitive Therapy',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                          ],
                        ),

                        AppButton(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.notesScreen,
                          ),
                          height: 33,
                          text: 'Notes',
                          width: 96,
                          textSize: 13,
                          isColor: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: 11.h,
                  left: 20.w,
                  right: 12.w,
                  bottom: 10.h,
                ),
                height: 143.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.primaryColor),
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Oct 15,2025 - 9:00AM',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                            CustomText(
                              text: 'Cognitive Therapy',
                              fontSize: 15,
                              color: AppColors.secondaryTextColor,
                            ),
                          ],
                        ),

                        AppButton(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.notesScreen,
                          ),
                          height: 33,
                          text: 'Notes',
                          width: 96,
                          textSize: 13,
                          isColor: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 23.h),
            ],
          ),
        ),
      ),
    );
  }
}
