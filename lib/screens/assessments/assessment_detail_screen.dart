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
import '../../widgets/row_text.dart';
import '../../widgets/show_msg.dart';
import 'bloc/consultant_assesment_event.dart';
import 'bloc/consultant_assesment_state.dart';

class AssessmentDetailScreen extends StatefulWidget {
  final String? visitId;
  const AssessmentDetailScreen({super.key, this.visitId = ''});

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
        if (state is ConsultantMessageState) {
          isLoading = false;
          AppMsg.showSnackBar(context, message: state.message.toString());
          message = state.message;
        }
        if (kDebugMode) {
          print(state);
        }
      },

      builder: (context, state) {
        if (state is ConsultantFromHomeLoaded) {
          allConsultantAssessmentModel = state.allConsultantAssessmentModel;
          assessmentLength = allConsultantAssessmentModel?.length ?? 0;
          currentPatientModel = state.currentPatientModel;

          return RefreshIndicator(
            onRefresh: () async => context.read<ConsultantAssessmentBloc>().add(
              ConsultantAssessmentEvent(isRefresh: true),
            ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.bgColor,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                centerTitle: true,
                title: Text('Consultant Assessments'),
                automaticallyImplyLeading: false,
              ),
              backgroundColor: AppColors.bgColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    children: List.generate(assessmentLength, (index) {
                      clinicalFindings =
                          allConsultantAssessmentModel![index].clinicalFindings;
                      settingsModel =
                          allConsultantAssessmentModel![index].sessionSettings;
                      adviceModel = allConsultantAssessmentModel![index].advice;
                      prescriptionModel =
                          allConsultantAssessmentModel![index].prescription;
                      selectedPackages =
                          allConsultantAssessmentModel![index].selectedPackages;
                      specialTest =
                          allConsultantAssessmentModel![index].specialTests;
                      mmt = allConsultantAssessmentModel![index].mmt;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PatientInfoCardWidget(
                            patientName:
                                currentPatientModel?.patient?.displayName ?? '',
                            gender:
                                currentPatientModel?.patient?.displayGender ??
                                '',
                            cnic:
                                currentPatientModel?.patient?.displayCnic ?? '',
                            age: currentPatientModel?.patient?.displayAge ?? '',
                            consultant:
                                allConsultantAssessmentModel![index].consultant,
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
                          SpecialTestsWidget(specialTests: specialTest ?? {}),
                          SizedBox(height: 20.h),
                          AdviceInvestigationsWidget(
                            investigationsDone: adviceModel!.investigationsDone,
                            otherInvestigationsAdvice: adviceModel!.otherAdvice
                                .toString(),
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
            ),
          );
        } else if (state is ConsultantLoadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(
            body: isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
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
                          onTap: () => context
                              .read<ConsultantAssessmentBloc>()
                              .add(ConsultantAssessmentEvent(isRefresh: true)),
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
