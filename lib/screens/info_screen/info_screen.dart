import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'info_widgets/info_appbar.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AboutTheropyAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(),
        children: List.generate((6), (index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                height: 210.h,
                width: 350.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/WhatsApp Image 2025-11-19 at 5.05.31 PM (1) 1.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
