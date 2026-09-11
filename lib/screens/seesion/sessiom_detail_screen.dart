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
import '../../widgets/app_app_bar.dart';
import '../../widgets/app_empty_state.dart';
import '../../widgets/app_pull_refresh.dart';
import '../../widgets/app_shimmer.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/row_text.dart';
import '../../widgets/show_msg.dart';
import 'bloc/session_bloc.dart';
import 'bloc/session_event.dart';

class SessionDetailScreen extends StatefulWidget {
  final String? visitId;
  final bool embedded;
  const SessionDetailScreen({
    super.key,
    this.visitId = '',
    this.embedded = false,
  });

  @override
  State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends State<SessionDetailScreen> {
  CurrentPatientModel? currentPatientData;
  TherapySessionsResponseModel? therapySessionsModel;
  String? id = '0';

  bool isLoading = false;
  bool isRefreshing = false;
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
        if (state is SessionLoadingState) {
          if (allTherapistModel == null) {
            isLoading = true;
          } else {
            isRefreshing = true;
          }
        } else {
          isLoading = false;
          isRefreshing = false;
        }
        if (state is SessionMessageState) {
          message = state.message.toString();
        }
        _syncAppBarLoading();
      },
      builder: (context, state) {
        if (state is SessionFromHomeLoaded) {
          print('From Home /..............');
          allTherapistModel = state.allTherapistModel;
          currentPatientData = state.patientData;
        }

        final firstLoad = isLoading && allTherapistModel == null;
        final appBarLoading = isLoading || isRefreshing;

        if (allTherapistModel != null) {
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

          return _sessionShell(
            isLoading: appBarLoading,
            body: widget.embedded
                ? AppPullRefresh(
                    enabled: !appBarLoading,
                    onRefresh: () async {
                      final bloc = context.read<TherapySessionBloc>();
                      final done = bloc.stream.firstWhere(
                        (s) =>
                            s is SessionFromHomeLoaded ||
                            s is SessionMessageState,
                      );
                      bloc.add(TherapySessionEvent(refresh: true));
                      await done;
                    },
                    child: filteredVisits.isNotEmpty
                        ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
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
                        : _therapyEmpty(),
                  )
                : SafeArea(
                    child: AppPullRefresh(
                      enabled: !appBarLoading,
                      onRefresh: () async {
                        final bloc = context.read<TherapySessionBloc>();
                        final done = bloc.stream.firstWhere(
                          (s) =>
                              s is SessionFromHomeLoaded ||
                              s is SessionMessageState,
                        );
                        bloc.add(TherapySessionEvent(refresh: true));
                        await done;
                      },
                      child: filteredVisits.isNotEmpty
                          ? ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
                              children: [
                                SizedBox(height: 16.h),
                                ...filteredVisits.expand((items) {
                                  final summary = items.summary!.visitSummary;
                                  final sessions = items.sessions;
                                  final allVisitsIds = allTherapistModel!
                                      .visitWiseSessions!
                                      .expand(
                                        (e) => e.sessions!.map(
                                          (_) =>
                                              e.summary!.visitSummary!.visitID,
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
                                          currentPatientData!.patient?.name ??
                                          '',
                                      cnic:
                                          currentPatientData!.patient?.cnic ??
                                          '',
                                      ageGender:
                                          currentPatientData!.patient?.gender ??
                                          '',
                                      startedAt: '10:30',
                                      endedAt: '10:40',
                                      packageUsed: session.packageUsed ?? '',
                                      sessionDuration:
                                          session.sessionDurationTotal ?? '',
                                      sessionNumber:
                                          session.sessionID.toString(),
                                      visitDate:
                                          DateAndTimeFormater.dateFormat(
                                        summary?.visitDate,
                                      ),
                                      modalities: List.generate(
                                        (session.modalitiesPerformed?.length ??
                                            0),
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
                          : _therapyEmpty(),
                    ),
                  ),
          );
        }

        if (firstLoad || state is SessionLoadingState) {
          return _sessionShell(
            isLoading: true,
            body: const AppListShimmer(),
          );
        }

        return _sessionShell(
          body: _therapyEmpty(message: message),
        );
      },
    );
  }

  Widget _therapyEmpty({String? message}) {
    return AppEmptyRefreshView(
      child: AppEmptyState.therapySession(
        message: message,
        onRetry: () => context.read<TherapySessionBloc>().add(
          TherapySessionEvent(id: widget.visitId, refresh: true),
        ),
      ),
    );
  }

  Widget _sessionShell({required Widget body, bool isLoading = false}) {
    if (widget.embedded) {
      return ColoredBox(color: AppColors.bgColor, child: body);
    }
    return Scaffold(
      appBar: AppAppBar(
        title: 'Sessions',
        showBack: true,
        isLoading: isLoading,
      ),
      backgroundColor: AppColors.bgColor,
      body: body,
    );
  }

  void _syncAppBarLoading() {
    if (!widget.embedded || !mounted) return;
    final loading = isLoading || isRefreshing;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      AppBarLoadingNotification(loading).dispatch(context);
    });
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
