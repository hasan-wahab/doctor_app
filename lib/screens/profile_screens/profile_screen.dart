import 'dart:async';
import 'dart:convert';

import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_state.dart';
import 'package:doctor_app/screens/nfc_card/nfc_card.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';
import 'package:doctor_app/screens/profile_screens/widgets/profile_appbar.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../core/extentions/internect_connectivity.dart';
import '../../core/functions.dart';
import '../../data/api_service/api_service.dart';
import '../../data/local_storage/local_storage.dart';
import '../../data/models/current_patient_model.dart';
import '../auth_screen/bloc/login_bloc.dart';
import '../auth_screen/bloc/login_events.dart';
import '../auth_screen/login_screen/auth_model/login_model_1.dart';
import '../nave_bar/nave_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginModel1? profileData;
  String? currentUserToken;
  CurrentPatientModel? currentPatientData;
  late Timer _timer;

  bool hasInternet = false;
  bool isLoading = false;

  @override
  void initState() {
    context.read<ProfileBloc>().add(MyProfileEvent());
    internetController();
    super.initState();
  }

  void internetController() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (Timer t) async {
      hasInternet = await InternetUtils.isInternetAvailable();
      if (!mounted) return; // ✅ IMPORTANT
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          context.read<NaveBarBloc>().add(NaveBarIndexEvent(index: 0));
        }
      },
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadingState) {
            isLoading = true;
          } else if (state is MyProfileState) {
            isLoading = false;
            profileData = state.profileData;
            currentPatientData = state.currentPatientModel;
          } else if (state is ProfileMessageState) {
            isLoading = false;
            AppMsg.showSnackBar(context, message: state.message!);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: ProfileAppbar(
              title: 'Profile',
              isLeading: true,
              leadingOnTap: () {
                context.read<NaveBarBloc>().add(NaveBarIndexEvent(index: 0));
              },
            ),
            body: isLoading == false
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
                                          child: currentPatientData != null
                                              ? hasInternet
                                                    ? ClipOval(
                                                        child:
                                                            // profileData!.user!.profilePicture != null
                                                            //    ?
                                                            Image.network(
                                                              fit: BoxFit.cover,
                                                              currentPatientData!
                                                                  .patient!
                                                                  .displayImageUrl,

                                                              headers: {
                                                                "Authorization":
                                                                    "Bearer ${profileData!.accessToken.toString()}",
                                                              },
                                                              errorBuilder:
                                                                  (
                                                                    context,
                                                                    error,
                                                                    stackTrace,
                                                                  ) {
                                                                    return Container();
                                                                  },
                                                            ),
                                                      )
                                                    : Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 50.h,
                                                        width: 50.w,
                                                        decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        child: CustomText(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.sp,
                                                          text: getFirstTwoInitials(
                                                            currentPatientData!
                                                                .patient!
                                                                .displayName
                                                                .toString(),
                                                          ),
                                                        ),
                                                      )
                                              : Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CustomText(
                                    text: currentPatientData!
                                        .patient!
                                        .user!
                                        .displayName
                                        .toString(),
                                    fontSize: 20,
                                  ),

                                  CustomText(
                                    text:
                                        'Patient ID: ${profileData!.user!.id.toString()}',
                                    color: AppColors.secondaryTextColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: 40.h),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.push(AppRoutes.myProfileScreen);
                                      },
                                      child: Card(
                                        color: AppColors.secondaryColor,

                                        child: Padding(
                                          padding: EdgeInsets.all(15.r),
                                          child: SizedBox(
                                            // height: 50.h,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  spacing: 10.w,
                                                  children: [
                                                    Icon(
                                                      Icons.person,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    CustomText(
                                                      text: 'My Profile',
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
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
                                        context.push(
                                          AppRoutes.myNFCCardScreen,
                                          extra: true,
                                        );
                                      },
                                      child: Card(
                                        color: AppColors.secondaryColor,
                                        child: Padding(
                                          padding: EdgeInsets.all(15.r),
                                          child: SizedBox(
                                            // height: 50.h,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  spacing: 10.w,
                                                  children: [
                                                    Icon(
                                                      Icons.credit_card,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    CustomText(text: 'My Card'),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
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
                                        context.push(AppRoutes.mapScreen);
                                      },
                                      child: Card(
                                        color: AppColors.secondaryColor,

                                        child: Padding(
                                          padding: EdgeInsets.all(15.r),
                                          child: SizedBox(
                                            // height: 50.h,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  spacing: 10.w,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    CustomText(
                                                      text: 'Location',
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
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
                                        final Uri url = Uri.parse(
                                          'https://dralitherapy.com/privacy-policy/',
                                        );

                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(
                                            url,
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        } else {
                                          throw Exception(
                                            'Could not launch $url',
                                          );
                                        }
                                      },
                                      child: Card(
                                        color: AppColors.secondaryColor,
                                        child: Padding(
                                          padding: EdgeInsets.all(15.r),
                                          child: SizedBox(
                                            // height: 50.h,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  spacing: 10.w,
                                                  children: [
                                                    Icon(
                                                      Icons.security,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    CustomText(
                                                      text: 'Privacy Policy',
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
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
                                          msg:
                                              'Are your sure you want to log out',
                                          actionText: 'No',
                                          actionText2: 'Yes',
                                          action2: () async {
                                            Navigator.pop(context);
                                            context.read<NaveBarBloc>().add(
                                              NaveBarLogoutEvent(),
                                            );
                                          },
                                        );
                                      },
                                      child: Card(
                                        color: AppColors.secondaryColor,
                                        child: Padding(
                                          padding: EdgeInsets.all(15.r),
                                          child: SizedBox(
                                            // height: 50.h,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  spacing: 10.w,
                                                  children: [
                                                    Icon(
                                                      Icons.logout,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    CustomText(text: 'Log Out'),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
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
                              ),
                            ],
                          ),
                        )
                      : Center(child: CircularProgressIndicator())
                : Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
