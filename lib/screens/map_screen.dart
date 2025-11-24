import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                zoom: 13,
                target: LatLng(33.6996, 73.0362),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 55.h,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Select city',
                    color: AppColors.secondaryTextColor,
                    fontSize: 16,
                  ),
                  Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 51.h,
                      width: 162.w,
                      decoration: BoxDecoration(
                        color: AppColors.linkTextColor,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Row(
                        spacing: 5.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: 106,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 4.0.h),
                              child: Icon(
                                Icons.send,
                                color: AppColors.whiteIconColor,
                              ),
                            ),
                          ),
                          CustomText(
                            text: 'Nearby Labs',
                            color: AppColors.textWhiteColor,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: AppColors.linkTextColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        CupertinoIcons.arrow_turn_up_right,
                        size: 30.sp,
                        color: AppColors.whiteIconColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
