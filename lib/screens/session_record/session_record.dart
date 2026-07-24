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
import 'package:doctor_app/screens/session_record/session_notes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../core/extentions/context_extentions.dart';
import '../../core/functions.dart';
import '../../data/api_service/api_service.dart';
import '../../data/local_storage/local_storage.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/app_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/date_time_foemat.dart';
import '../../widgets/new-widget/session_progress_card.dart';
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
  List<VisitModel> visits = [];

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
          visits = state.visits!;
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
                                      spacing: 10.w,
                                      children: List.generate(
                                        currentPatientData!
                                                .patient!
                                                .packages
                                                .isNotEmpty
                                            ? currentPatientData!
                                                  .patient!
                                                  .packages
                                                  .length
                                            : 1,

                                        (index) {
                                          final packageName =
                                              currentPatientData!
                                                  .patient!
                                                  .packages[index]
                                                  .displayName
                                                  .toSentenceCase;
                                          final completedSessions =
                                              currentPatientData!
                                                  .patient!
                                                  .packages[index]
                                                  .pivot!
                                                  .sessionsUsed!;
                                          final totalSessions =
                                              currentPatientData!
                                                  .patient!
                                                  .packages[index]
                                                  .sessions!;
                                          return Container(
                                            margin: EdgeInsets.only(
                                              bottom: 10.h,
                                            ),

                                            height: 120.h,
                                            width:
                                                currentPatientData!
                                                        .patient!
                                                        .packages!
                                                        .length ==
                                                    1
                                                ? 350.w
                                                : 300,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: SessionProgressCard(
                                              title: packageName,
                                              progressLabel: 'Progress',
                                              completedSessions:
                                                  completedSessions,
                                              nextSessionLabel:
                                                  totalSessions ==
                                                      completedSessions
                                                  ? 'Completed'
                                                  : currentPatientData!
                                                        .therapySessions
                                                        .isEmpty
                                                  ? ''
                                                  : currentPatientData
                                                            ?.therapySessions[index]
                                                            .displayNextSessionDate ==
                                                        'No data'
                                                  ? ''
                                                  : 'Next Session',
                                              nextSessionDate:
                                                  totalSessions ==
                                                      completedSessions
                                                  ? ''
                                                  : currentPatientData!
                                                        .therapySessions
                                                        .isEmpty
                                                  ? ''
                                                  : DateAndTimeFormater.dateFormat(
                                                      currentPatientData
                                                          ?.therapySessions[index]
                                                          .nextSessionDate,
                                                    ),
                                              totalSessions: totalSessions,
                                            ),
                                          );
                                        },
                                      ),
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
                                      //CustomText(text: '', fontSize: 12),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),

                                  ...List.generate(visits.length, (index) {
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
                                                      visits[index].therapist !=
                                                              null
                                                          ? CustomText(
                                                              text: visits[index]
                                                                  .therapist!
                                                                  .displayName,
                                                              fontSize: 20,
                                                              color: AppColors
                                                                  .firstTextBlackColor,
                                                            )
                                                          : CustomText(
                                                              text: 'No Data',
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
                                                        text:
                                                            DateAndTimeFormater.dateFormat(
                                                              visits[index]
                                                                  .displayVisitAt
                                                                  .toString(),
                                                            ),
                                                        fontSize: 15,
                                                        color: AppColors
                                                            .secondaryTextColor,
                                                      ),
                                                      CustomText(
                                                        text: visits[index]
                                                            .displayType,
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
                                                      String id = visits[index]
                                                          .displayId;
                                                      var type =
                                                          visits[index]
                                                                  .consultant ==
                                                              null
                                                          ? false
                                                          : true;
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                          builder: (context) =>
                                                              SessionNotes(
                                                                isConsultation:
                                                                    type,
                                                                visitId: id,
                                                              ),
                                                        ),
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
                      //Session Records
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
                                                          visits[index]
                                                                  .therapist !=
                                                              null
                                                          ? visits[index]
                                                                .therapist!
                                                                .displayName
                                                          : 'No therapist',
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

                                                        text:
                                                            DateAndTimeFormater.dateFormat(
                                                              visits[index]
                                                                  .displayVisitAt
                                                                  .toString(),
                                                            ),
                                                        fontSize: 15,
                                                        color: AppColors
                                                            .secondaryTextColor,
                                                      ),
                                                    ),
                                                    CustomText(
                                                      textOverflow:
                                                          TextOverflow.ellipsis,
                                                      text: visits[index]
                                                          .displayType,
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
}
