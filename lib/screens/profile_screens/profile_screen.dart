import 'dart:convert';
import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/local_storage/local_storage.dart';
import 'package:doctor_app/screens/profile_screens/widgets/profile_appbar.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../auth_screen/login_screen/auth_model/login_model_1.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginModel1? profileData;

  @override
  void initState() {
    getCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ProfileAppbar(title: 'Profile'),
      body: profileData != null
          ? Padding(
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
                                  image: NetworkImage(
                                    profileData!.user!.profilePicture
                                        .toString(),
                                  ),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomText(
                        text: profileData!.user!.name.toString(),
                        fontSize: 20,
                      ),
                      CustomText(
                        text: 'Patient ID: ${profileData!.user!.id.toString()}',
                        color: AppColors.secondaryTextColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Column(
                    spacing: 20.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.myProfileScreen,
                          );
                        },
                        child: Card(
                          color: AppColors.secondaryColor,

                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: SizedBox(
                              height: 50.h,

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    spacing: 10.w,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: AppColors.primaryColor,
                                      ),
                                      CustomText(text: 'My Profile'),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18.r,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.myNFCCardScreen,
                          );
                        },
                        child: Card(
                          color: AppColors.secondaryColor,
                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: SizedBox(
                              height: 50.h,

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    spacing: 10.w,
                                    children: [
                                      Icon(
                                        Icons.credit_card,
                                        color: AppColors.primaryColor,
                                      ),
                                      CustomText(text: 'My Card'),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18.r,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.mapScreen);
                        },
                        child: Card(
                          color: AppColors.secondaryColor,

                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: SizedBox(
                              height: 50.h,

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    spacing: 10.w,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: AppColors.primaryColor,
                                      ),
                                      CustomText(text: 'Location'),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18.r,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          AppMsg.showErrorMsg(
                            context,
                            msgTitle: 'Confirmation!',
                            msg: 'Are your sure you want to log out',
                            actionText: 'No',
                            actionText2: 'Yes',
                            action2: () async {
                              await LocalStorage.userLogOutToken().then((
                                  onValue,
                                  ) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.naveBar,
                                      (Route<dynamic> route) => true,
                                );
                              });
                            },
                          );
                        },
                        child: Card(
                          color: AppColors.secondaryColor,
                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: SizedBox(
                              height: 50.h,

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    spacing: 10.w,
                                    children: [
                                      Icon(
                                        Icons.logout,
                                        color: AppColors.primaryColor,
                                      ),
                                      CustomText(text: 'Log Out'),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18.r,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  void getCurrentUserData() async {
    String? token = await LocalStorage.getUserToken('token');
    String? data = await LocalStorage.getProfileData(token!);
    if (data != null) {
      Map<String, dynamic> jsonData = jsonDecode(data);
      profileData = LoginModel1.fromJson(jsonData);
      setState(() {});
    }
  }
}
