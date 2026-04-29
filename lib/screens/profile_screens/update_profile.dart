import 'dart:io';
import 'dart:math';

import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/screens/nave_bar/nave_bar.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/widgets/profile_appbar.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/api_service/api_service.dart';
import '../../data/local_storage/local_storage.dart';
import '../../widgets/custom_text.dart';
import '../auth_screen/login_screen/auth_model/login_model_1.dart';
import 'bloc/profile_state.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool isLoading = false;
  String? selectedValue;
  DateTime? pickedData;
  CurrentPatientModel? currentPatientModel;
  LoginModel1? profileData;

  @override
  void initState() {
    context.read<ProfileBloc>().add(MyProfileEvent());

    super.initState();
  }

  String? name, email, cnic, phone;
  File? pickImage;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          isLoading = true;
        } else if (state is ProfileMessageState) {
          isLoading = false;
          if (kDebugMode) {
            print(state.message);
          }
          AppMsg.showSnackBar(context, message: state.message!);

          print("From update profile ${state.toString()}");
        } else if (state is MyProfileState) {
          isLoading = false;
          currentPatientModel = state.currentPatientModel;
          profileData = state.profileData;
          name = currentPatientModel!.patient!.displayName.toString();
          email = currentPatientModel!.patient!.displayEmail.toString();
          cnic = currentPatientModel!.patient!.displayCnic.toString();
          phone = currentPatientModel!.patient!.displayPhone.toString();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: ProfileAppbar(title: 'Update profile', isLeading: true),
          backgroundColor: AppColors.bgColor,
          body: currentPatientModel != null && profileData != null
              ? isLoading != true
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 20.h,
                          ),
                          child: Column(
                            spacing: 15.h,
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
                                          width: 118.h,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.primaryColor,
                                              width: 2.h,
                                            ),

                                            shape: BoxShape.circle,
                                          ),
                                          child: isLoading == false
                                              ? pickImage == null
                                                    ? ClipOval(
                                                        child: Image.network(
                                                          fit: BoxFit.cover,
                                                          currentPatientModel!
                                                              .patient!
                                                              .displayImageUrl
                                                              .toString(),
                                                          headers: {
                                                            "Authorization":
                                                                "Bearer ${profileData!.accessToken.toString()}",
                                                          },
                                                        ),
                                                      )
                                                    : ClipOval(
                                                        child: Image.file(
                                                          fit: BoxFit.cover,
                                                          pickImage!,
                                                        ),
                                                      )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ],
                                                ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            pickImageFromUser();
                                          },
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              height: 32.h,
                                              width: 32.w,
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: AppColors.whiteIconColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CustomText(
                                    text: profileData!
                                        .patientData!
                                        .patientInfo!
                                        .name
                                        .toString(),
                                    fontSize: 20,
                                  ),
                                  CustomText(
                                    text: 'Patient ID: #MC-2025',
                                    color: AppColors.secondaryTextColor,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: 'Name'),
                                  Container(
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),

                                      border: Border.all(
                                        color: AppColors.secondaryTextColor,
                                      ),
                                    ),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        name = value;
                                      },
                                      initialValue: currentPatientModel!
                                          .patient!
                                          .displayName
                                          .toString(),
                                      //  controller: nameController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: 'Phone'),
                                  Container(
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),

                                      border: Border.all(
                                        color: AppColors.secondaryTextColor,
                                      ),
                                    ),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        phone = value;
                                      },
                                      initialValue: currentPatientModel!
                                          .patient!
                                          .displayPhone
                                          .toString(),

                                      // controller: phoneController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: 'DOB'),

                                  InkWell(
                                    onTap: () {
                                      String dateStr = profileData!
                                          .patientData!
                                          .patientInfo!
                                          .birthDate
                                          .toString();

                                      // ✅ FIX: ISO parse
                                      DateTime parsedDate = DateTime.parse(
                                        dateStr,
                                      );

                                      showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1800),
                                        lastDate: DateTime.now(),
                                        initialDate: parsedDate,
                                      ).then((pickedDate1) {
                                        if (pickedDate1 != null) {
                                          setState(() {
                                            pickedData = pickedDate1;
                                          });
                                        }
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Text(
                                        pickedData != null
                                            ? DateFormat(
                                                "MM/dd/yyyy",
                                              ).format(pickedData!)
                                            : profileData
                                                      ?.patientData
                                                      ?.patientInfo
                                                      ?.birthDate !=
                                                  null
                                            ? DateFormat("MM/dd/yyyy").format(
                                                DateTime.parse(
                                                  profileData!
                                                      .patientData!
                                                      .patientInfo!
                                                      .birthDate,
                                                ),
                                              )
                                            : 'No data',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: 'Email'),
                                  Container(
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),

                                      border: Border.all(
                                        color: AppColors.secondaryTextColor,
                                      ),
                                    ),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        email = value;
                                      },
                                      initialValue: currentPatientModel!
                                          .patient!
                                          .displayEmail
                                          .toString(),
                                      //    controller: emailController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              AppButton(
                                text: 'Update',
                                onTap: () async {
                                  isLoading = true;
                                  if (name != null &&
                                      email != null &&
                                      cnic != null &&
                                      phone != null) {
                                    context.read<ProfileBloc>().add(
                                      UpdateProfileEvent(
                                        path: pickImage,
                                        name: name!,
                                        email: email!,
                                        cnic: cnic!,
                                        phone: phone!,
                                      ),
                                    );
                                  } else {
                                    print('No trigerred');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(child: CircularProgressIndicator())
              : Center(child: Text('No data')),
        );
      },
    );
  }

  void pickImageFromUser() async {
    setState(() {
      isLoading == true;
    });
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picker != null) {
      final pickedImage = File(picker.path);

      pickImage = pickedImage;
      setState(() {
        isLoading == false;
      });
    }
  }
}
