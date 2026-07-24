import 'package:doctor_app/data/models/all_therapist_model.dart';
import 'package:doctor_app/data/models/therapay_session_model.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';
import 'package:doctor_app/screens/seesion/bloc/session_state.dart';
import 'package:doctor_app/screens/seesion/widgets/session_report_session_body.dart';
import 'package:doctor_app/screens/seesion/widgets/session_report_session_card.dart';
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
  final String? visitId;
  const SessionDetailScreen({super.key, this.visitId = ''});

  @override
  State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends State<SessionDetailScreen> {
  CurrentPatientModel? currentPatientData;
  TherapySessionsResponseModel? therapySessionsModel;
  String? id = '0';

  bool isLoading = false;
  AllTerapistModle? allTherapistModel;
  String? message;
  @override
  Future<void> didChangeDependencies() async {
    context.read<ProfileBloc>().add(MyProfileEvent());
    context.read<TherapySessionBloc>().add(
      TherapySessionEvent(id: widget.visitId),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TherapySessionBloc, TherapySessionState>(
      listener: (context, state) {
        if (state is SessionMessageState) {
          message = state.message.toString();
          isLoading = false;
          AppMsg.showSnackBar(context, message: state.message.toString());
        }
      },
      builder: (context, state) {
        if (state is SessionFromHomeLoaded) {
          print('From Home /..............');
          allTherapistModel = state.allTherapistModel;
          currentPatientData = state.patientData;
          final sessions = allTherapistModel!.visitWiseSessions;
          List filteredVisits;
          if (widget.visitId != null && widget.visitId != '') {
            filteredVisits = sessions!.where((item) {
              return item.summary!.visitSummary?.visitID.toString() ==
                  widget.visitId;
            }).toList();
          } else {
            filteredVisits = sessions!;
          }

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
                        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
                        children: [
                          SizedBox(height: 16.h),
                          ...filteredVisits.expand((items) {
                            final summary = items.summary!.visitSummary;
                            final sessions = items.sessions;
                            final allVisitsIds = allTherapistModel!
                                .visitWiseSessions!
                                .expand(
                                  (e) => e.sessions!.map(
                                    (_) => e.summary!.visitSummary!.visitID,
                                  ),
                                )
                                .toList();
                            bool isDup =
                                allVisitsIds
                                    .where((id) => id == summary!.visitID)
                                    .toList()
                                    .length >
                                1;
                            return sessions!.map((session) {
                              return SessionReportSessionCard(
                                terapistName: session.therapist ?? '',
                                patientName:
                                    currentPatientData!.patient?.name ?? '',
                                cnic: currentPatientData!.patient?.cnic ?? '',
                                ageGender:
                                    currentPatientData!.patient?.gender ?? '',
                                startedAt: '10:30',

                                endedAt: '10:40',
                                packageUsed: session.packageUsed ?? '',
                                sessionDuration:
                                    session.sessionDurationTotal ?? '',
                                sessionNumber: session.sessionID.toString(),
                                visitDate: DateAndTimeFormater.dateFormat(
                                  summary?.visitDate,
                                ),
                                modalities: List.generate(
                                  (session.modalitiesPerformed?.length ?? 0),
                                  (index2) {
                                    return ModalityEntity(
                                      title:
                                          session
                                              .modalitiesPerformed![index2]
                                              .modality ??
                                          '',
                                      duration:
                                          session
                                              .modalitiesPerformed![index2]
                                              .duration ??
                                          '',
                                    );
                                  },
                                ),
                              );
                            });
                          }).toList(),
                        ],
                      )
                    : Center(child: CustomText(text: 'No data found!')),
              ),
            ),
          );
        }
        if (state is SessionLoadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(
            body: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                spacing: 10.h,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: message == 'No internet connection!'
                        ? message!
                        : 'No data',
                  ),
                  InkWell(
                    onTap: () => context.read<TherapySessionBloc>().add(
                      TherapySessionEvent(id: widget.visitId),
                    ),
                    child: Icon(Icons.refresh),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

// CustomText(
// maxLines: 3,
// text: 'Therapy Sessions',
// fontSize: 20,
// color: AppColors.primaryColor,
// ),
//
// Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: List.generate(
// allTherapistModel!.visitWiseSessions!.length,
// (index) {
// final completedVisitsModel = allTherapistModel!
//     .visitWiseSessions![index];
// final sessionData =
// completedVisitsModel.sessions![index];
// final summary =
// completedVisitsModel.summary!.visitSummary;
// return
// },
// ),
// ),
