import 'dart:convert';



import 'package:doctor_app/screens/profile_screens/widgets/profile_appbar.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../data/api_service/api_service.dart';
import '../../data/local_storage/local_storage.dart';
import '../../data/models/current_patient_model.dart';

import '../auth_screen/login_screen/auth_model/login_model_1.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String? userToken;
  LoginModel1? profileData;
  CurrentPatientModel? currentPatientData;
  var err;

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
      body: currentPatientData != null
          ? profileData != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 110.h,
                              width: 110.h,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 110.h,
                                    width: 110.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 2.h,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: currentPatientData != null
                                        ? ClipOval(
                                            child: Image.network(
                                              fit: BoxFit.cover,
                                              'https://alitherapy.neonweb.tech/storage/${currentPatientData!.patient!.image.toString()}',

                                              headers: {
                                                "Authorization":
                                                    "Bearer ${profileData!.accessToken.toString()}",
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    err = error;
                                                    return profileData!.user !=
                                                            null
                                                        ? Image.network(
                                                            profileData!
                                                                .user!
                                                                .profilePicture
                                                                .toString(),
                                                          )
                                                        : Container();
                                                  },
                                            ),
                                          )
                                        : Center(
                                            child: CircularProgressIndicator(),
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
                                              err == null
                                                  ? 'https://alitherapy.neonweb.tech/storage/${currentPatientData!.patient!.image.toString()}'
                                                  : profileData!
                                                        .user!
                                                        .profilePicture
                                                        .toString(),
                                              currentPatientData!.patient!.name
                                                  .toString(),
                                              currentPatientData!.patient!.phone
                                                  .toString(),
                                              'Male',
                                              DateAndTimeFormater.dateFormat(
                                                currentPatientData!
                                                    .patient!
                                                    .birthDate
                                                    .toString(),
                                              ),
                                              currentPatientData!.patient!.email
                                                  .toString(),
                                              currentPatientData!.patient!.cnic
                                                  .toString(),
                                              profileData!.accessToken
                                                  .toString(),
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
                              text: currentPatientData!.patient!.name
                                  .toString(),
                              fontSize: 20,
                            ),
                            CustomText(
                              text: 'Patient ID: #MC-2025',
                              color: AppColors.secondaryTextColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 40),

                        Column(
                          spacing: 20.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              color: AppColors.secondaryColor,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  spacing: 20.w,
                                  children: [
                                    Icon(
                                      Icons.person_2_outlined,
                                      color: AppColors.primaryColor,
                                      size: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Name',
                                          fontSize: 12,
                                          color: AppColors.primaryColor,
                                        ),
                                        CustomText(
                                          text: currentPatientData!
                                              .patient!
                                              .name
                                              .toString(),
                                          fontSize: 15,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: AppColors.secondaryColor,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  spacing: 20.w,
                                  children: [
                                    Icon(
                                      Icons.phone_outlined,
                                      color: AppColors.primaryColor,
                                      size: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Phone',
                                          fontSize: 12,
                                          color: AppColors.primaryColor,
                                        ),
                                        CustomText(
                                          text: currentPatientData!
                                              .patient!
                                              .phone
                                              .toString(),
                                          fontSize: 15,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: AppColors.secondaryColor,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  spacing: 20.w,
                                  children: [
                                    currentPatientData!.patient!.gender
                                                .toString() ==
                                            'Male'
                                        ? Icon(
                                            Icons.male,
                                            color: AppColors.primaryColor,
                                            size: 30,
                                          )
                                        : Icon(
                                            Icons.female,
                                            color: AppColors.primaryColor,
                                            size: 30,
                                          ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Gender',
                                          fontSize: 12,
                                          color: AppColors.primaryColor,
                                        ),
                                        CustomText(
                                          text: currentPatientData!
                                              .patient!
                                              .gender
                                              .toString(),
                                          fontSize: 15,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: AppColors.secondaryColor,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  spacing: 20.w,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: AppColors.primaryColor,
                                      size: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'DOB',
                                          fontSize: 12,
                                          color: AppColors.primaryColor,
                                        ),
                                        currentPatientData!
                                                    .patient!
                                                    .birthDate !=
                                                null
                                            ? CustomText(
                                                text:
                                                    DateAndTimeFormater.dateFormat(
                                                      currentPatientData!
                                                          .patient!
                                                          .birthDate
                                                          .toString(),
                                                    ),

                                                fontSize: 15,
                                              )
                                            : CustomText(text: "No data"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: AppColors.secondaryColor,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  spacing: 20.w,
                                  children: [
                                    Icon(
                                      Icons.cake_outlined,
                                      color: AppColors.primaryColor,
                                      size: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Age',
                                          fontSize: 12,
                                          color: AppColors.primaryColor,
                                        ),
                                        CustomText(
                                          text:
                                              DateAndTimeFormater.calculateAge(
                                                currentPatientData!
                                                    .patient!
                                                    .birthDate
                                                    .toString(),
                                              ).toString(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: AppColors.secondaryColor,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  spacing: 20.w,
                                  children: [
                                    Icon(
                                      Icons.email_outlined,
                                      color: AppColors.primaryColor,
                                      size: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Email',
                                          fontSize: 12,
                                          color: AppColors.primaryColor,
                                        ),
                                        CustomText(
                                          text: currentPatientData!
                                              .patient!
                                              .email
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator())
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
      getPatientData();
    }
  }

  void getPatientData() async {
    if (profileData != null) {
      currentPatientData = await ApiServices.getPatientData(
        patientId: profileData!.patientData!.patientInfo!.id.toString(),
        currentUserToken: profileData!.accessToken.toString(),
        context: context,
      );
      setState(() {});
    }
  }
}
