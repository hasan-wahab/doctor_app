import 'dart:convert';

import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/screens/profile_screens/widgets/profile_appbar.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../local_storage/local_storage.dart';
import '../auth_screen/login_screen/auth_model/login_model_1.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String? userToken;
  LoginModel1? profileData;

  @override
  void initState() {
    getUserToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: ProfileAppbar(title: 'Profile', isLeading: true),
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
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: ClipOval(
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  profileData?.user!.profilePicture ?? '',
                                  headers: {
                                    "Authorization":
                                        "Bearer ${profileData!.accessToken.toString()}",
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.updateProfile,
                                    arguments: <String, List<String>>{
                                      'data': [
                                        profileData!
                                            .patientData!
                                            .patientInfo!
                                            .image
                                            .toString(),
                                        profileData!.user!.name.toString(),
                                        profileData!.user!.phone.toString(),
                                        'Male',
                                        DateAndTimeFormater.dateFormat(
                                          profileData!
                                              .patientData!
                                              .patientInfo!
                                              .birthDate
                                              .toString(),
                                        ),
                                        profileData!.user!.email.toString(),
                                        profileData!.user!.cnic.toString(),
                                        profileData!.accessToken.toString(),
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
                      CustomText(
                        text: profileData!.user!.name.toString(),
                        fontSize: 20,
                      ),
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
                          CustomText(
                            text: profileData!.user!.name.toString(),
                            fontSize: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: 'Phone', fontSize: 20),
                          CustomText(
                            text: profileData!.user!.phone.toString(),
                            fontSize: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          CustomText(text: 'Gender', fontSize: 20),

                          CustomText(
                            text: profileData!.patientData!.patientInfo!.gender
                                .toString(),

                            fontSize: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          CustomText(text: 'DOB', fontSize: 20),

                          profileData!.patientData!.patientInfo!.birthDate ==
                                  null.toString()
                              ? CustomText(
                                  text: DateAndTimeFormater.dateFormat(
                                    profileData!
                                        .patientData!
                                        .patientInfo!
                                        .birthDate,
                                  ),

                                  fontSize: 20,
                                )
                              : CustomText(text: "No data"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          CustomText(text: 'Age', fontSize: 20),

                          CustomText(
                            text: DateAndTimeFormater.calculateAge(
                              profileData!.patientData!.patientInfo!.birthDate,
                            ).toString(),

                            fontSize: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: 'Email', fontSize: 20),
                          CustomText(
                            text: profileData!.user!.email.toString(),
                            fontSize: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  void getUserToken() async {
    userToken = await LocalStorage.getUserToken('token');
    if (userToken != null) {
      getCurrentUserData(userToken!);
    }
  }

  void getCurrentUserData(String token) async {
    String? data = await LocalStorage.getProfileData(userToken!);

    if (data != null) {
      Map<String, dynamic> jsonData = jsonDecode(data);

      profileData = LoginModel1.fromJson(jsonData);
      setState(() {});
    }
  }
}
