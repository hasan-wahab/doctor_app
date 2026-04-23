import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/show_msg.dart';
import '../profile_screens/bloc/profile_state.dart';

class SessionNotes extends StatefulWidget {
  const SessionNotes({super.key});

  @override
  State<SessionNotes> createState() => _SessionNotesState();
}

class _SessionNotesState extends State<SessionNotes> {
  bool isLoading = false;
  CurrentPatientModel? currentPatientData;
  bool isVisitDetail = false;
  Map<String, int>? index;

  @override
  void didChangeDependencies() {
    context.read<ProfileBloc>().add(MyProfileEvent());
    index = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          isLoading = true;
        } else {
          isLoading = false;
        }
        if (state is ProfileMessageState) {
          AppMsg.showErrorMsg(context, msg: state.message.toString());
        }
        if (state is MyProfileState) {
          currentPatientData = state.currentPatientModel;
        }
      },
      builder: (context, state) {
        return isLoading != true
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.bgColor,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  centerTitle: true,
                  title: Text('Visit detail'),
                  automaticallyImplyLeading: false,
                ),
                backgroundColor: AppColors.bgColor,
                body: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: currentPatientData != null
                      ? currentPatientData!.patient.visits.isEmpty
                            ? Center(child: Text('No data'))
                            : Column(
                                spacing:
                                    currentPatientData!
                                            .patient
                                            .visits[index!['index'] ?? 0]
                                            .consultantAssessment !=
                                        null
                                    ? 20.h
                                    : 0,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  currentPatientData!
                                              .patient
                                              .visits![index!['index'] ?? 0]
                                              .historyTaking !=
                                          null
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              AppRoutes.assessmentScreen,
                                              arguments: {
                                                "consultant":
                                                    currentPatientData!
                                                        .patient
                                                        .visits[index!['index'] ??
                                                        0],
                                              },
                                            );
                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 55.h,
                                            child: Card(
                                              margin: EdgeInsets.zero,
                                              color: AppColors.secondaryColor,
                                              child: Padding(
                                                padding: EdgeInsets.all(10.r),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomText(
                                                      text: 'History Tracker',
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
                                                      size: 14.r,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  currentPatientData!
                                              .patient
                                              .visits[index!['index'] ?? 0]
                                              .consultantAssessment !=
                                          null
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              AppRoutes.assistantManagerScreen,
                                              arguments: {
                                                "amAssessments":
                                                    currentPatientData!
                                                        .patient
                                                        .visits![index!['index'] ??
                                                        0],
                                              },
                                            );
                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 55.h,
                                            child: Card(
                                              margin: EdgeInsets.zero,
                                              color: AppColors.secondaryColor,
                                              child: Padding(
                                                padding: EdgeInsets.all(10.r),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          'Assistant Manager Assessment',
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
                                                      size: 14.r,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  currentPatientData!
                                              .patient
                                              .visits![index!['index'] ?? 0]
                                              .consultantAssessment !=
                                          null
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              AppRoutes.assessmentScreen,
                                              arguments: {
                                                "consultant":
                                                    currentPatientData!
                                                        .patient
                                                        .visits![index!['index'] ??
                                                        0],
                                              },
                                            );
                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 55.h,
                                            child: Card(
                                              margin: EdgeInsets.zero,
                                              color: AppColors.secondaryColor,
                                              child: Padding(
                                                padding: EdgeInsets.all(10.r),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          'Consultant Assessment',
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
                                                      size: 14.r,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),

                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.sessionsDetailScreen,
                                        arguments: {
                                          "therapySession": currentPatientData!
                                              .patient
                                              .visits![index!['index'] ?? 0],
                                        },
                                      );
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 55.h,
                                      child: Card(
                                        margin: EdgeInsets.zero,
                                        color: AppColors.secondaryColor,
                                        child: Padding(
                                          padding: EdgeInsets.all(10.r),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text: 'Therapy Session',
                                                color: AppColors.primaryColor,
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 14.r,
                                                color: AppColors.primaryColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                      : Center(child: CircularProgressIndicator()),
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
