import 'dart:io';

import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/screens/home/home_screen.dart';
import 'package:doctor_app/screens/home/home_screen_2.dart';
import 'package:doctor_app/screens/info_screen/info_screen.dart';
import 'package:doctor_app/screens/map_screen.dart';
import 'package:doctor_app/screens/profile_screens/profile_screen.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NaveBar extends StatefulWidget {
  const NaveBar({super.key});

  @override
  State<NaveBar> createState() => _NaveBarState();
}

class _NaveBarState extends State<NaveBar> {
  int currentIndex = 0;
  final List<String> iconText = ['Home', 'Location', 'About', 'Account'];
  final List<IconData> icons = [
    Icons.home,
    Icons.location_on_outlined,
    Icons.info_outline,
    Icons.person_2_outlined,
  ];
  List<Widget> screenList = [
    HomeScreen2(),
    MapScreen(),
    InfoScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(currentIndex),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
        height: Platform.isIOS ? 701.h : 100.h,
        color: AppColors.secondaryColor,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate((iconText.length), (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      icons[index],
                      color: currentIndex == index
                          ? AppColors.primaryColor
                          : AppColors.blackIconColor,
                    ),
                    CustomText(
                      text: iconText[index],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: currentIndex == index
                          ? AppColors.primaryColor
                          : AppColors.blackIconColor,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
