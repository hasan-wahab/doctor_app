import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/show_msg.dart';
import '../history_tracker_screen/bloc/history_tracker_bloc.dart';
import '../history_tracker_screen/bloc/history_tracker_event.dart';
import '../profile_screens/bloc/profile_state.dart';

class SessionNotes extends StatefulWidget {
  final String visitId;
  bool isConsultation;
  SessionNotes({super.key, this.visitId = '', this.isConsultation = false});

  @override
  State<SessionNotes> createState() => _SessionNotesState();
}

class _SessionNotesState extends State<SessionNotes> {
  bool isLoading = false;
  CurrentPatientModel? currentPatientData;
  LoginModel1? profileData;
  bool isVisitDetail = false;
  String? visitID;
  List<VisitModel> visits = [];

  @override
  void initState() {
    visitID = widget.visitId;
    print(visitID);
    context.read<ProfileBloc>().add(MyProfileEvent());
    super.initState();
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
          profileData = state.profileData;
        }
      },
      builder: (context, state) {
        if (isLoading != true) {
          return Scaffold(
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
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: currentPatientData != null
                  ? currentPatientData!.patient!.visits.isEmpty
                        ? Center(child: Text('No data'))
                        : Column(
                            spacing: 20.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.isConsultation != true
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        context.push(
                                          AppRoutes.historyTrackerScreen,
                                          extra: visitID,
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
                              // widget.isConsultation != true
                              //     ? Container()
                              //     : InkWell(
                              //         onTap: () {
                              //           Navigator.pushNamed(
                              //             context,
                              //             AppRoutes.assistantManagerScreen,
                              //           );
                              //         },
                              //         child: SizedBox(
                              //           width: double.infinity,
                              //           height: 55.h,
                              //           child: Card(
                              //             margin: EdgeInsets.zero,
                              //             color: AppColors.secondaryColor,
                              //             child: Padding(
                              //               padding: EdgeInsets.all(10.r),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 children: [
                              //                   CustomText(
                              //                     text:
                              //                         'Assistant Manager Assessment',
                              //                     color: AppColors.primaryColor,
                              //                   ),
                              //                   Icon(
                              //                     Icons
                              //                         .arrow_forward_ios_outlined,
                              //                     size: 14.r,
                              //                     color: AppColors.primaryColor,
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              widget.isConsultation != true
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        context.push(
                                          AppRoutes.assessmentScreen,
                                          extra: visitID,
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
                                                  text: 'Consultant Assessment',
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

                              InkWell(
                                onTap: () {
                                  context.push(
                                    AppRoutes.sessionsDetailScreen,
                                    extra: visitID ?? '',
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
                                            Icons.arrow_forward_ios_outlined,
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
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
