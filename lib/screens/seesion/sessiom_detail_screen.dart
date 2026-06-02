import 'package:doctor_app/data/models/all_therapist_model.dart';
import 'package:doctor_app/data/models/therapay_session_model.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';
import 'package:doctor_app/screens/seesion/bloc/session_state.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/row_text.dart';
import '../../widgets/show_msg.dart';
import 'bloc/session_bloc.dart';
import 'bloc/session_event.dart';

class SessionDetailScreen extends StatefulWidget {
  const SessionDetailScreen({super.key});

  @override
  State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends State<SessionDetailScreen> {
  CurrentPatientModel? currentPatientData;
  TherapySessionsResponseModel? therapySessionsModel;
  String? id;

  bool isLoading = false;
  AllTherapistModel? allTherapistModel;
  @override
  Future<void> didChangeDependencies() async {
    id = ModalRoute.of(context)!.settings.arguments as String?;
    print(id);
    context.read<ProfileBloc>().add(MyProfileEvent());
    context.read<TherapySessionBloc>().add(TherapySessionEvent(id: id));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TherapySessionBloc, TherapySessionState>(
      listener: (context, state) {
        if (state is SessionMessageState) {
          isLoading = false;
          AppMsg.showSnackBar(context, message: state.message.toString());
        }
        if (state is SessionFromHomeLoaded) {
          print(state.allTherapistModel!.totalSessionCount);
        }
      },
      builder: (context, state) {
        if (state is SessionLoadedFromRecordsState) {
          print('From Record /..............');
          therapySessionsModel = state.model;
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
              title: Text('Sessions'),
              automaticallyImplyLeading: false,
            ),
            backgroundColor: AppColors.bgColor,
            body: therapySessionsModel != null
                ? ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    children: [
                      CustomText(
                        text: 'Therapy Sessions',
                        fontSize: 20,
                        color: AppColors.primaryColor,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(
                          therapySessionsModel!.sessions.length,
                          (index) {
                            return Card(
                              color: AppColors.secondaryColor,
                              margin: EdgeInsets.only(top: 15.h),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 20.h,
                                ),

                                //  height: 178.h,
                                width: 360.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  //  border: Border.all(color: AppColors.primaryColor, width: 2),
                                ),

                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RowText(
                                      firstText: 'Sessions#',
                                      secondText: therapySessionsModel!
                                          .sessions[index]
                                          .displaySessionNumber
                                          .toString(),
                                    ),
                                    RowText(
                                      firstText: 'Next session date',
                                      secondText:
                                          DateAndTimeFormater.dateFormat(
                                            therapySessionsModel!
                                                .sessions[index]
                                                .nextSessionDate,
                                          ),
                                    ),
                                    RowText(
                                      firstText: 'Therapist',
                                      secondText: therapySessionsModel!
                                          .sessions[index]
                                          .displayTherapist,
                                    ),

                                    RowText(
                                      firstText: 'Duration',
                                      secondText: therapySessionsModel!
                                          .sessions[index]
                                          .sessionDurationTotal,
                                    ),
                                    RowText(
                                      firstText: 'Notes',
                                      secondText: therapySessionsModel!
                                          .sessions[index]
                                          .displayClinicalNotes,
                                    ),
                                    RowText(
                                      firstText: 'CrateAt',
                                      secondText: therapySessionsModel!
                                          .sessions[index]
                                          .displayCreatedAt,
                                    ),
                                    RowText(
                                      firstText: 'Active time',
                                      secondText: therapySessionsModel!
                                          .sessions[index]
                                          .displayActiveTime,
                                    ),
                                    RowText(
                                      firstText: 'Package Used',
                                      secondText: therapySessionsModel!
                                          .sessions[index]
                                          .displayPackageUsed,
                                    ),
                                    RowText(
                                      firstText: 'Duration Total',
                                      secondText: therapySessionsModel!
                                          .sessions[index]
                                          .displaySessionDurationTotal,
                                    ),
                                    ...List.generate(
                                      (therapySessionsModel!
                                          .sessions[index]
                                          .modalitiesPerformed
                                          .length),
                                      (generate) => RowText(
                                        firstText: therapySessionsModel!
                                            .sessions[index]
                                            .modalitiesPerformed[generate]
                                            .displayModality,
                                        secondText: therapySessionsModel!
                                            .sessions[index]
                                            .modalitiesPerformed[generate]
                                            .displayDuration,
                                      ),
                                    ),

                                    RowText(
                                      firstText: 'Visit Summary',
                                      secondText: therapySessionsModel!
                                          .summary!
                                          .visitSummary!
                                          .toJson()
                                          .values
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          );
        }
        if (state is SessionFromHomeLoaded) {
          print('From Home /..............');
          allTherapistModel = state.allTherapistModel;
          currentPatientData = state.patientData;
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
              title: Text('Sessions'),
              automaticallyImplyLeading: false,
            ),
            backgroundColor: AppColors.bgColor,
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async => context.read<TherapySessionBloc>().add(
                  TherapySessionEvent(refresh: true),
                ),
                child: allTherapistModel != null
                    ? ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        children: [
                          CustomText(
                            maxLines: 3,
                            text: 'Therapy Sessions',
                            fontSize: 20,
                            color: AppColors.primaryColor,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(
                              allTherapistModel!.totalSessionCount,
                              (index) {
                                TherapistVisitGroupModel completedVisitsModel =
                                    allTherapistModel!.completedVisits[0];
                               print(completedVisitsModel.sessionCount);
                                return Card(
                                  color: AppColors.secondaryColor,
                                  margin: EdgeInsets.only(top: 15.h),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                      vertical: 20.h,
                                    ),

                                    //   height: 178.h,
                                    width: 360.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      //  border: Border.all(color: AppColors.primaryColor, width: 2),
                                    ),

                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // All Session model
                                        RowText(
                                          firstText: 'Sessions#',
                                          secondText: allTherapistModel!
                                              .allSessions[index]
                                              .displaySessionId
                                              .toString(),
                                        ),
                                        RowText(
                                          firstText: 'Next session date',
                                          secondText:
                                              DateAndTimeFormater.dateFormat(
                                                allTherapistModel!
                                                    .allSessions[index]
                                                    .displayNextSessionDate
                                                    .toString(),
                                              ),
                                        ),
                                        RowText(
                                          firstText: 'Therapist',
                                          secondText: allTherapistModel!
                                              .allSessions[index]
                                              .displayTherapist
                                              .toString(),
                                        ),

                                        RowText(
                                          firstText: 'Duration',
                                          secondText: allTherapistModel!
                                              .allSessions[index]
                                              .sessionDurationTotal
                                              .toString(),
                                        ),
                                        RowText(
                                          firstText: 'Notes',
                                          secondText: allTherapistModel!
                                              .allSessions[index]
                                              .clinicalNotes,
                                        ),
                                        RowText(
                                          firstText: 'Package',
                                          secondText: allTherapistModel!
                                              .allSessions[index]
                                              .displayPackageUsed,
                                        ),
                                        RowText(
                                          firstText: 'Active time',
                                          secondText: allTherapistModel!
                                              .allSessions[index]
                                              .displayActiveTime,
                                        ),
                                        RowText(
                                          firstText: 'Created at',
                                          secondText: allTherapistModel!
                                              .allSessions[index]
                                              .displayCreatedAt,
                                        ),
                                        RowText(
                                          firstText: 'Next session date',
                                          secondText: allTherapistModel!
                                              .allSessions[index]
                                              .displayNextSessionDate,
                                        ),
                                       // Complete visit model
                                        RowText(
                                          firstText: 'Visit Status',
                                          secondText: completedVisitsModel
                                              .visitSummary!
                                              .displayVisitStatus,
                                        ),
                                        RowText(
                                          firstText: 'Current Stage',
                                          secondText: completedVisitsModel
                                              .visitSummary!
                                              .displayCurrentStage,
                                        ),
                                        RowText(
                                          firstText: 'Clinic',
                                          secondText: completedVisitsModel
                                              .visitSummary!
                                              .displayClinic,
                                        ),
                                        RowText(
                                          firstText: 'Visit Date',
                                          secondText: completedVisitsModel
                                              .visitSummary!
                                              .displayVisitDate,
                                        ),
                                        RowText(
                                          firstText: 'Visit Id',
                                          secondText: completedVisitsModel
                                              .visitSummary!
                                              .displayVisitId,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        }
        if (state is SessionLoadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(
            body: Center(child: CustomText(text: 'No Data')),
          );
        }
      },
    );
  }
}
