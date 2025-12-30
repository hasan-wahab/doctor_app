import 'dart:convert';

import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/models/current_patient_model.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_api_service/auth_api_services.dart';
import 'package:doctor_app/screens/profile_screens/widgets/profile_appbar.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/cupertino.dart';
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
  CurrentPatientModel? currentPatientData;

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
                                      child:
                                          // profileData!.user!.profilePicture != null
                                          //    ?
                                          Image.network(
                                            fit: BoxFit.cover,
                                            'https://alitherapy.neonweb.tech/storage/${currentPatientData!.patient!.image.toString()}',

                                            headers: {
                                              "Authorization":
                                                  "Bearer ${profileData!.accessToken.toString()}",
                                            },
                                          ),
                                    )
                                  : Center(child: CircularProgressIndicator()),
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
                                        'https://alitherapy.neonweb.tech/storage/${currentPatientData!.patient!.image.toString()}',
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
                  SizedBox(height: 40),

                  Column(
                    spacing: 20.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          print(currentPatientData!.patient!.image);
                        },
                        child: Card(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'Name',
                                      fontSize: 12,
                                      color: AppColors.primaryColor,
                                    ),
                                    CustomText(
                                      text: profileData!.user!.name.toString(),
                                      fontSize: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Phone',
                                    fontSize: 12,
                                    color: AppColors.primaryColor,
                                  ),
                                  CustomText(
                                    text: profileData!.user!.phone.toString(),
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
                              profileData!.patientData!.patientInfo!.gender
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Gender',
                                    fontSize: 12,
                                    color: AppColors.primaryColor,
                                  ),
                                  CustomText(
                                    text: profileData!
                                        .patientData!
                                        .patientInfo!
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'DOB',
                                    fontSize: 12,
                                    color: AppColors.primaryColor,
                                  ),
                                  profileData!
                                              .patientData!
                                              .patientInfo!
                                              .birthDate !=
                                          null.toString()
                                      ? CustomText(
                                          text: DateAndTimeFormater.dateFormat(
                                            profileData!
                                                .patientData!
                                                .patientInfo!
                                                .birthDate,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Age',
                                    fontSize: 12,
                                    color: AppColors.primaryColor,
                                  ),
                                  CustomText(
                                    text: DateAndTimeFormater.calculateAge(
                                      profileData!
                                          .patientData!
                                          .patientInfo!
                                          .birthDate,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Email',
                                    fontSize: 12,
                                    color: AppColors.primaryColor,
                                  ),
                                  CustomText(
                                    text: profileData!.user!.email.toString(),
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
      currentPatientData = await AuthApiServices.getPatientData(
        patientId: profileData!.patientData!.patientInfo!.id.toString(),
        currentUserToken: profileData!.accessToken.toString(),
        context: context,
      );
      setState(() {});
    }
  }
}
