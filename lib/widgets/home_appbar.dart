import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/app_routes/routes_name.dart';
import '../core/app_styles/app_colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                spacing: 6.w,
                children: [
                  // Profile image
                  Container(
                    alignment: Alignment.center,
                    height: 50.h,
                    width: 50.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor
                      )
                    ),
                    child: CustomText(text: 'GU',color: AppColors.primaryColor,fontWeight: FontWeight.w500,fontSize: 22.sp,),
                  ),

                  // Name
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyle(
                              color: AppColors.secondaryTextColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.poppins.toString(),
                              fontSize: 17.sp,
                            ),
                          ),
                          Text(
                            'Guest User',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.poppins.toString(),
                              fontSize: 17.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ],
              ),

              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.loginScreen);
                },
                child: SizedBox(
                  height: 22.h,
                  width: 64.w,

                  child: Row(
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: GoogleFonts.poppins.toString(),
                        ),
                      ),
                      Icon(Icons.login, size: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70.h);
}
