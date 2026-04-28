import 'dart:convert';

import 'package:doctor_app/data/api_service/base_api/base_api_impl.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_impl.dart';
import 'package:doctor_app/data/models/history_traker_model.dart';
import 'package:doctor_app/repos/history_tracker_repo/history_tracker_repo_Impl.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/history_tracker_screen/bloc/history_tracker_bloc.dart';
import 'package:doctor_app/screens/history_tracker_screen/bloc/history_tracker_event.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:doctor_app/screens/nave_bar/nave_bar.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../data/api_service/api_service.dart';
import '../../data/local_storage/local_storage.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/app_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/date_time_foemat.dart';
import '../../widgets/show_msg.dart';
import '../profile_screens/bloc/profile_state.dart';

class SessionRecord extends StatefulWidget {
  const SessionRecord({super.key});

  @override
  State<SessionRecord> createState() => _SessionRecordState();
}

class _SessionRecordState extends State<SessionRecord> {
  bool isLoading = false;
  CurrentPatientModel? currentPatientData;
  LoginModel1? profileData;
  bool isVisitDetail = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(MyProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          isLoading = true;
        } else if (state is MyProfileState) {
          isLoading = false;
          profileData = state.profileData;
          currentPatientData = state.currentPatientModel;
        } else {
          isLoading = false;
          AppMsg.showErrorMsg(context, msg: state.toString());
        }
      },
      builder: (context, state) {
        final latestData = state is MyProfileState
            ? state.currentPatientModel
            : currentPatientData;

        if (isLoading || latestData == null) {
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        currentPatientData = latestData;
        final visits = List.from(latestData.patient.visits);

        visits.sort(
          (a, b) => (a.visitAt ?? DateTime.fromMillisecondsSinceEpoch(0))
              .compareTo(b.visitAt ?? DateTime.fromMillisecondsSinceEpoch(0)),
        );
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            context.read<NaveBarBloc>().add(NaveBarIndexEvent(index: 0));
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.bgColor,
              leading: IconButton(
                onPressed: isVisitDetail == true
                    ? () {
                        setState(() {
                          isVisitDetail = false;
                        });
                      }
                    : () {
                        context.read<NaveBarBloc>().add(
                          NaveBarIndexEvent(index: 0),
                        );
                      },
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              centerTitle: true,
              title: Text(
                isVisitDetail == true ? 'Total visits' : 'Session Records',
              ),
              automaticallyImplyLeading: false,
            ),
            backgroundColor: AppColors.bgColor,
            body: visits.isNotEmpty
                ? isVisitDetail == true
                      // Visit Records
                      ? RefreshIndicator(
                          onRefresh: () async {
                            context.read<ProfileBloc>().add(MyProfileEvent());
                          },
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15.h),
                                  CustomText(
                                    text: 'Session Progress',
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(height: 10.h),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ...List.generate(
                                          currentPatientData!
                                                  .patient
                                                  .packages
                                                  .isNotEmpty
                                              ? currentPatientData!
                                                    .patient
                                                    .packages
                                                    .length
                                              : 1,

                                          (index) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                bottom: 10.h,
                                              ),

                                              height: 110.h,
                                              width:
                                                  currentPatientData!
                                                          .patient
                                                          .packages
                                                          .length ==
                                                      1
                                                  ? 350.w
                                                  : 300,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                              ),
                                              child: Card(
                                                color: AppColors.secondaryColor,
                                                margin: EdgeInsets.zero,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10.h,
                                                    vertical: 10,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            currentPatientData!
                                                                .patient
                                                                .packages
                                                                .isEmpty
                                                            ? 'No data'
                                                            : currentPatientData!
                                                                  .patient
                                                                  .packages[index]
                                                                  .name
                                                                  .toString(),
                                                        fontSize: 12,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                'Sessions Progress',
                                                            fontSize: 12,
                                                            color: AppColors
                                                                .secondaryTextColor,
                                                          ),
                                                          CustomText(
                                                            text: '',
                                                            //  '${currentPatientData!.patient!.packages.isNotEmpty ? currentPatientData!.patient!.packages[index].pivot![index].sessionTotal : 0}/${currentPatientData!.patient!.packages.isNotEmpty ? currentPatientData!.patient!.packages[index].pivot![index].sessionUsed : 0}',
                                                            fontSize: 10,
                                                          ),
                                                        ],
                                                      ),

                                                      LinearProgressIndicator(
                                                        value:
                                                            currentPatientData!
                                                                .patient
                                                                .packages
                                                                .isEmpty
                                                            ? 1.0
                                                            : getSessionProgress(
                                                                index,
                                                              ),
                                                        valueColor:
                                                            AlwaysStoppedAnimation(
                                                              AppColors
                                                                  .primaryColor,
                                                            ),
                                                      ),

                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                'Next Session Date',
                                                            fontSize: 15,
                                                          ),
                                                          CustomText(
                                                            text:
                                                                currentPatientData!
                                                                    .patient!
                                                                    .packages
                                                                    .isNotEmpty
                                                                ? DateAndTimeFormater.dateFormat(
                                                                    currentPatientData!
                                                                        .therapySessions[index]
                                                                        .nextSessionDate
                                                                        .toString(),
                                                                  )
                                                                : 'No data',
                                                            fontSize: 12,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),

                                  /// All Visits
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: 'My Visits',
                                        color: AppColors.primaryColor,
                                      ),
                                      CustomText(text: '23/9', fontSize: 12),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),

                                  ...List.generate(visits.length, (index) {
                                    final visit = visits[index];

                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      alignment: Alignment.center,

                                      height: 120.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      child: Card(
                                        margin: EdgeInsets.zero,
                                        color: AppColors.secondaryColor,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 11.h,
                                            left: 20.w,
                                            right: 12.w,
                                            bottom: 10.h,
                                          ),
                                          child: Column(
                                            children: [
                                              /// TOP ROW
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            visit
                                                                    .therapist
                                                                    ?.name
                                                                    .isNotEmpty ==
                                                                true
                                                            ? visit
                                                                  .therapist!
                                                                  .name
                                                            : 'no data',
                                                        fontSize: 20,
                                                        color: AppColors
                                                            .firstTextBlackColor,
                                                      ),

                                                      const CustomText(
                                                        text: 'Physiotherapist',
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        size: 20.r,
                                                        color: Colors.amber,
                                                      ),
                                                      const CustomText(
                                                        text: '4.5',
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                              const Spacer(),

                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text: visit.visitAt
                                                            .toString(),
                                                        fontSize: 15,
                                                        color: AppColors
                                                            .secondaryTextColor,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            visit.type ??
                                                            'Cognitive Therapy',
                                                        fontSize: 15,
                                                        color: AppColors
                                                            .secondaryTextColor,
                                                      ),
                                                    ],
                                                  ),
                                                  AppButton(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8.r,
                                                        ),
                                                    onTap: () async {
                                                      Navigator.pushNamed(
                                                        context,
                                                        AppRoutes.notesScreen,
                                                        arguments: visits[index]
                                                            .id
                                                            .toString(),
                                                      );
                                                    },
                                                    height: 33,
                                                    text: 'Visit Details',
                                                    width: 96,
                                                    textSize: 13,
                                                    isColor: false,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            context.read<ProfileBloc>().add(MyProfileEvent());
                          },
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: visits.length > 5
                                  ? MediaQuery.sizeOf(context).height - 150
                                  : null,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  children: [
                                    SizedBox(height: 23.h),
                                    ...List.generate(1, (index) {
                                      final visit = visits[index];
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 10.h),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                          top: 11.h,
                                          left: 20.w,
                                          right: 12.w,
                                          bottom: 10.h,
                                        ),
                                        height: 120.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: AppColors.primaryColor,
                                          ),
                                          color: AppColors.bgColor,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            /// TOP ROW
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          visit
                                                                  .therapist
                                                                  ?.name
                                                                  .isNotEmpty ==
                                                              true
                                                          ? visit
                                                                .therapist!
                                                                .name
                                                          : 'no data',
                                                      fontSize: 20,
                                                      color: AppColors
                                                          .firstTextBlackColor,
                                                    ),
                                                    const CustomText(
                                                      text: 'Physiotherapist',
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: 20.r,
                                                      color: Colors.amber,
                                                    ),
                                                    const CustomText(
                                                      text: '4.5',
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            const Spacer(),

                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 190,
                                                      child: CustomText(
                                                        maxLines: 1,
                                                        textOverflow:
                                                            TextOverflow
                                                                .ellipsis,

                                                        text: visit.visitAt
                                                            .toString(),
                                                        fontSize: 15,
                                                        color: AppColors
                                                            .secondaryTextColor,
                                                      ),
                                                    ),
                                                    CustomText(
                                                      textOverflow:
                                                          TextOverflow.ellipsis,
                                                      text:
                                                          visit.type ??
                                                          'Cognitive Therapy',
                                                      fontSize: 15,
                                                      color: AppColors
                                                          .secondaryTextColor,
                                                    ),
                                                  ],
                                                ),
                                                AppButton(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        8.r,
                                                      ),
                                                  onTap: () {
                                                    setState(() {
                                                      isVisitDetail = true;
                                                    });
                                                  },
                                                  height: 33,
                                                  text: 'Consultation',
                                                  width: 96,
                                                  textSize: 13,
                                                  isColor: false,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                : Center(child: Text('No data')),
          ),
        );
      },
    );
  }

  double getSessionProgress(int index) {
    final total =
        currentPatientData!.patient.packages[index].pivot['sessions_total'];
    final used =
        currentPatientData!.patient.packages[index].pivot['sessions_used'];

    if (total == 0) return 0.0;

    final progress = used! / total!;

    if (progress.isNaN || progress.isInfinite) return 0.0;

    return progress.clamp(0.0, 1.0);
  }
}
