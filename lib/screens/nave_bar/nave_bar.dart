import 'dart:io';

import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/login_screen.dart';
import 'package:doctor_app/screens/dashboard_screen/dashbord_screen.dart';
import 'package:doctor_app/screens/home/home_screen.dart';
import 'package:doctor_app/screens/map_screen.dart';
import 'package:doctor_app/screens/nfc_card/nfc_card.dart';
import 'package:doctor_app/screens/profile_screens/profile_screen.dart';
import 'package:doctor_app/screens/session_record/session_record.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../local_storage/local_storage.dart';

class NaveBar extends StatefulWidget {
  int? currentIndex;
  NaveBar({super.key, this.currentIndex = 0});

  @override
  State<NaveBar> createState() => _NaveBarState();
}

class _NaveBarState extends State<NaveBar> {
  int currentIndex = 0;
  String? token;
  final List<String> iconText = ['Home', 'My card', 'Records', 'Account'];
  final List<IconData> icons = [
    Icons.home,
    Icons.credit_card,
    Icons.list_alt_rounded,
    Icons.person_2_outlined,
  ];
  List<Widget> screenList = [
    HomeScreen(),
    MapScreen(isNavigateFromNaveBar: true),
    SessionRecord(),
    LoginScreen(),
  ];
  List<Widget> screenList2 = [
    DashbordScreen(),
    NfcCard(),
    SessionRecord(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    getToken();
    if (widget.currentIndex == null) {
      currentIndex = 0;
    } else {
      currentIndex = widget.currentIndex!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: token == null
          ? screenList.elementAt(currentIndex != 0 ? 3 : currentIndex)
          : screenList2.elementAt(currentIndex),
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
                    if (token == null) {
                      if (index == 1) {
                        currentIndex = 3;
                      } else if (index == 2) {
                        currentIndex = 3;
                      } else if (index == 3) {
                        currentIndex = 3;
                      } else {
                        currentIndex = index;
                      }
                    } else {
                      currentIndex = index;
                    }
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

  void getToken() async {
    token = await LocalStorage.getUserToken('token');
    setState(() {});
  }
}
