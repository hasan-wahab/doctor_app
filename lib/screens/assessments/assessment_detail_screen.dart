import 'package:doctor_app/screens/assessments/bloc/consultant_assesmant_bloc.dart';
import 'package:doctor_app/screens/assessments/widgets/advice_investigations.dart';
import 'package:doctor_app/screens/assessments/widgets/assigned_packages.dart';
import 'package:doctor_app/screens/assessments/widgets/clinical_findings.dart';
import 'package:doctor_app/screens/assessments/widgets/mmt_table.dart';
import 'package:doctor_app/screens/assessments/widgets/muscle_assessments.dart';
import 'package:doctor_app/screens/assessments/widgets/patient_info_card.dart';
import 'package:doctor_app/screens/assessments/widgets/session_settings.dart';
import 'package:doctor_app/screens/assessments/widgets/special_tests.dart';
import 'package:doctor_app/screens/assessments/widgets/therapeutic_prescription.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';
import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/models/all_consutant_assessment_model.dart';
import '../../data/models/consultant_assesment_model.dart' hide AdviceModel;
import '../../data/models/current_patient_model.dart'
    hide ConsultantAssessmentModel, MuscleAssessmentModel;
import '../../widgets/app_empty_state.dart';
import '../../widgets/app_pull_refresh.dart';
import '../../widgets/app_shimmer.dart';
import '../../widgets/row_text.dart';
import '../../widgets/show_msg.dart';
import 'bloc/consultant_assesment_event.dart';
import 'bloc/consultant_assesment_state.dart';

class AssessmentDetailScreen extends StatefulWidget {
  final String? visitId;
  final bool embedded;
  const AssessmentDetailScreen({
    super.key,
    this.visitId = '',
    this.embedded = false,
  });

  @override
  State<AssessmentDetailScreen> createState() => _AssessmentDetailScreenState();
}

class _AssessmentDetailScreenState extends State<AssessmentDetailScreen> {
  List<AllConsultantAssessmentModel>? allConsultantAssessmentModel;
  CurrentPatientModel? currentPatientModel;
  ClinicalFindings? clinicalFindings;
  ConsultantAssessmentModel? consultantAssessments;
  MuscleAssessmentModel? muscleAssessmentModel;
  SessionSettings? settingsModel;
  AdviceModel? adviceModel;
  GeneralTherapeuticPrescription? prescriptionModel;
  List<String>? selectedPackages;
  Map<String, List<SpecialTest>>? specialTest;
  Map<String, List<MmtEntry>>? mmt;
  int assessmentLength = 0;

  String? id;
  bool isLoading = false;
  bool isRefreshing = false;
  String? message;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    context.read<ConsultantAssessmentBloc>().add(
      ConsultantAssessmentEvent(id: widget.visitId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantAssessmentBloc, ConsultantAssessmentState>(
      listener: (context, state) {
        if (state is ConsultantLoadingState) {
          if (allConsultantAssessmentModel == null) {
            isLoading = true;
          } else {
            isRefreshing = true;
          }
        } else {
          isLoading = false;
          isRefreshing = false;
        }
        if (state is ConsultantMessageState) {
          message = state.message;
        }
        if (kDebugMode) {
          print(state);
        }
        _syncAppBarLoading();
      },

      builder: (context, state) {
        if (state is ConsultantFromHomeLoaded) {
          allConsultantAssessmentModel = state.allConsultantAssessmentModel;
          assessmentLength = allConsultantAssessmentModel?.length ?? 0;
          currentPatientModel = state.currentPatientModel;
        }

        final firstLoad =
            allConsultantAssessmentModel == null && (isLoading || state is ConsultantLoadingState);
        final appBarLoading = isLoading || isRefreshing;

        final body = firstLoad
              ? const AppListShimmer()
              : allConsultantAssessmentModel == null
              ? AppPullRefresh(
                  enabled: !appBarLoading,
                  onRefresh: () async {
                    final bloc = context.read<ConsultantAssessmentBloc>();
                    final done = bloc.stream.firstWhere(
                      (s) =>
                          s is ConsultantFromHomeLoaded ||
                          s is ConsultantMessageState,
                    );
                    bloc.add(ConsultantAssessmentEvent(isRefresh: true));
                    await done;
                  },
                  child: AppEmptyRefreshView(
                    child: AppEmptyState.consultant(
                      message: message,
                      onRetry: () => context
                          .read<ConsultantAssessmentBloc>()
                          .add(ConsultantAssessmentEvent(isRefresh: true)),
                    ),
                  ),
                )
              : SafeArea(
                  child: AppPullRefresh(
                    enabled: !appBarLoading,
                    onRefresh: () async {
                      final bloc = context.read<ConsultantAssessmentBloc>();
                      final done = bloc.stream.firstWhere(
                        (s) =>
                            s is ConsultantFromHomeLoaded ||
                            s is ConsultantMessageState,
                      );
                      bloc.add(ConsultantAssessmentEvent(isRefresh: true));
                      await done;
                    },
                    child: assessmentLength == 0
                        ? AppEmptyRefreshView(
                            child: AppEmptyState.consultant(
                              onRetry: () => context
                                  .read<ConsultantAssessmentBloc>()
                                  .add(
                                    ConsultantAssessmentEvent(isRefresh: true),
                                  ),
                            ),
                          )
                        : SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 20.h,
                            ),
                            child: Column(
                              children: List.generate(assessmentLength, (index) {
                                clinicalFindings =
                                    allConsultantAssessmentModel![index]
                                        .clinicalFindings;
                                settingsModel =
                                    allConsultantAssessmentModel![index]
                                        .sessionSettings;
                                adviceModel =
                                    allConsultantAssessmentModel![index].advice;
                                prescriptionModel =
                                    allConsultantAssessmentModel![index]
                                        .prescription;
                                selectedPackages =
                                    allConsultantAssessmentModel![index]
                                        .selectedPackages;
                                specialTest =
                                    allConsultantAssessmentModel![index]
                                        .specialTests;
                                mmt = allConsultantAssessmentModel![index].mmt;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PatientInfoCardWidget(
                                      patientName:
                                          currentPatientModel
                                              ?.patient
                                              ?.displayName ??
                                          '',
                                      gender:
                                          currentPatientModel
                                              ?.patient
                                              ?.displayGender ??
                                          '',
                                      cnic:
                                          currentPatientModel
                                              ?.patient
                                              ?.displayCnic ??
                                          '',
                                      age:
                                          currentPatientModel
                                              ?.patient
                                              ?.displayAge ??
                                          '',
                                      consultant:
                                          allConsultantAssessmentModel![index]
                                              .consultant,
                                    ),
                                    SizedBox(height: 20.h),
                                    ClinicalFindingWidget(
                                      tags: clinicalFindings?.diagnosis ?? [],
                                      notes: clinicalFindings?.note ?? '',
                                    ),
                                    SizedBox(height: 20.h),
                                    SessionSettingsWidget(
                                      duration: settingsModel?.duration ?? '0',
                                    ),
                                    SizedBox(height: 20.h),
                                    SpecialTestsWidget(
                                      specialTests: specialTest ?? {},
                                    ),
                                    SizedBox(height: 20.h),
                                    AdviceInvestigationsWidget(
                                      investigationsDone:
                                          adviceModel?.investigationsDone ??
                                          [],
                                      otherInvestigationsAdvice:
                                          adviceModel?.otherAdvice
                                              ?.toString() ??
                                          '',
                                    ),
                                    SizedBox(height: 20.h),
                                    MMTTableWidget(mmt: mmt ?? {}),
                                    SizedBox(height: 20.h),
                                    MuscleAssessmentsWidget(
                                      muscleAssessments:
                                          allConsultantAssessmentModel![index]
                                              .muscleAssessments,
                                    ),
                                    SizedBox(height: 20.h),
                                    TherapeuticPrescriptionWidget(
                                      prescription: prescriptionModel,
                                    ),
                                    SizedBox(height: 20.h),
                                    AssignedPackagesWidget(
                                      selectedPackage: selectedPackages ?? [],
                                    ),
                                    SizedBox(height: 40.h),
                                  ],
                                );
                              }),
                            ),
                          ),
                  ),
                );

        if (widget.embedded) {
          return ColoredBox(color: AppColors.bgColor, child: body);
        }

        return Scaffold(
          appBar: AppAppBar(
            title: 'Consultant Assessments',
            showBack: true,
            isLoading: appBarLoading,
          ),
          backgroundColor: AppColors.bgColor,
          body: body,
        );
      },
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
