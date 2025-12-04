import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/screens/profile_screens/widgets/profile_appbar.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ProfileAppbar(title: 'Profile',isLeading: true,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 120.h,
                  width: 120.w,
                  child: Stack(
                    children: [
                      Container(
                        height: 118.h,
                        width: 118.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/profile_image.png',
                            ),
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.updateProfile,
                              arguments: <String,List<String>>{
                                'data': [
                                  'Hamza',
                                  '+92348560920',
                                  'Male',
                                  '12/02/2023',
                                  'abcd@gmail.com',
                                ],
                              },
                            );
                          },
                          child: Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: AppColors.whiteIconColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomText(text: 'Name', fontSize: 20),
                CustomText(
                  text: 'Patient ID: #MC-2025',
                  color: AppColors.secondaryTextColor,
                ),
              ],
            ),
            SizedBox(height: 80),
            Column(
              spacing: 20.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: 'Name', fontSize: 20),
                    CustomText(text: 'Hamza', fontSize: 20),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: 'Phone', fontSize: 20),
                    CustomText(text: '+92345678909', fontSize: 20),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: 'Gender', fontSize: 20),
                    CustomText(text: 'Male', fontSize: 20),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: 'DOB', fontSize: 20),
                    CustomText(text: 'DD/MM/YY', fontSize: 20),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: 'Email', fontSize: 20),
                    CustomText(text: 'abc@gmail.com', fontSize: 20),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
