import 'package:doctor_app/screens/assessments/bloc/consultant_assesmant_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/models/consultant_assesment_model.dart';
import '../../data/models/current_patient_model.dart'
    hide ConsultantAssessmentModel;
import '../../widgets/row_text.dart';
import '../../widgets/show_msg.dart';
import 'bloc/consultant_assesment_event.dart';
import 'bloc/consultant_assesment_state.dart';

class AssessmentDetailScreen extends StatefulWidget {
  const AssessmentDetailScreen({super.key});

  @override
  State<AssessmentDetailScreen> createState() => _AssessmentDetailScreenState();
}

class _AssessmentDetailScreenState extends State<AssessmentDetailScreen> {
  CurrentPatientModel? currentPatientData;
  ConsultantAssessmentModel? consultantAssessments;
  // var consultantAtIndex;

  String? id;
  bool isLoading = false;

  @override
  Future<void> didChangeDependencies() async {
    id = ModalRoute.of(context)!.settings.arguments as String?;
    super.didChangeDependencies();
    context.read<ConsultantAssessmentBloc>().add(
      ConsultantAssessmentEvent(id: id),
    );
    print("Id was ${id}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantAssessmentBloc, ConsultantAssessmentState>(
      listener: (context, state) {
        if (state is ConsultantMessageState) {
          isLoading = false;
          AppMsg.showSnackBar(context, message: state.message.toString());
        }
        print(state);
      },

      builder: (context, state) {
        if (state is ConsultantFromHomeLoaded) {
          currentPatientData = state.patientData;
          final consultantAssessmentData = currentPatientData!.patient!.visits;
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
              title: Text('Consultant Assessments'),
              automaticallyImplyLeading: false,
            ),
            backgroundColor: AppColors.bgColor,
            body: consultantAssessmentData.isNotEmpty
                ? ListView(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 10.h,
                      bottom: 60.h,
                    ),
                    children: [
                      CustomText(
                        text: 'Consultant Assessments',
                        fontSize: 20,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height: 30.h),

                      ...List.generate(
                        (consultantAssessmentData.isNotEmpty
                            ? consultantAssessmentData.length
                            : 1),
                        (index) {
                          return Card(
                            color: AppColors.secondaryColor,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20.h),
                              // height: 404.h,
                              width: 350.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    height: 40.h,
                                    width: 350.w,
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide()),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  1.3 -
                                              15,
                                          child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              CustomText(
                                                text:
                                                    consultantAssessmentData[index]
                                                            .consultant !=
                                                        null
                                                    ? consultantAssessmentData[index]
                                                          .consultant!
                                                          .displayName
                                                          .toString()
                                                    : '',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: CustomText(
                                      text: 'Assessment Finding',
                                      fontSize: 14,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  RowText(
                                    firstText: 'Observation',
                                    secondText:
                                        consultantAssessmentData[index]
                                                .consultantAssessment !=
                                            null
                                        ? consultantAssessmentData[index]
                                              .consultantAssessment!
                                              .displayObservationFindings
                                        : 'No data',
                                  ),

                                  RowText(
                                    firstText: 'Final Diagnosis',
                                    secondText:
                                        consultantAssessmentData[index]
                                                .consultantAssessment !=
                                            null
                                        ? consultantAssessmentData[index]
                                              .consultantAssessment!
                                              .displayFinalDiagnosis
                                        : 'No data',
                                  ),
                                  RowText(
                                    firstText: 'DifferentialDiagnoses',
                                    secondText:
                                        consultantAssessmentData[index]
                                                .consultantAssessment !=
                                            null
                                        ? consultantAssessmentData[index]
                                              .consultantAssessment!
                                              .displayDifferentialDiagnoses
                                        : 'No data',
                                  ),
                                  RowText(
                                    firstText: 'Final Diagnosis Other',
                                    secondText:
                                        consultantAssessmentData[index]
                                                .consultantAssessment !=
                                            null
                                        ? consultantAssessmentData[index]
                                              .consultantAssessment!
                                              .displayFinalDiagnosisOther
                                        : 'No data',
                                  ),

                                  RowText(
                                    firstText: 'Palpation',
                                    secondText:
                                        consultantAssessmentData[index]
                                                .consultantAssessment !=
                                            null
                                        ? consultantAssessmentData[index]
                                              .consultantAssessment!
                                              .displayPalpationResults
                                        : '',
                                  ),
                                  RowText(
                                    firstText: 'Next Review Date',
                                    secondText:
                                        consultantAssessmentData[index]
                                                .consultantAssessment !=
                                            null
                                        ? consultantAssessmentData[index]
                                              .consultantAssessment!
                                              .displayNextReviewDate
                                        : 'No data',
                                  ),
                                  RowText(
                                    firstText: 'ROM',
                                    secondText:
                                        consultantAssessmentData[index]
                                                .consultantAssessment !=
                                            null
                                        ? consultantAssessmentData[index]
                                              .consultantAssessment!
                                              .displayRomAssessment
                                        : 'No data',
                                  ),

                                  RowText(
                                    firstText: 'Neuro Test:',
                                    secondText:
                                        consultantAssessmentData[index]
                                                .consultantAssessment !=
                                            null
                                        ? consultantAssessmentData[index]
                                              .consultantAssessment!
                                              .displaySpecialTests
                                        : 'No data',
                                  ),
                                  Divider(thickness: 1, color: Colors.black),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: CustomText(
                                      text: 'Medications',
                                      fontSize: 14,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),

                                  RowText(
                                    firstText: 'Muscle Relaxant',
                                    secondText:
                                        consultantAssessmentData[index]
                                                .consultantAssessment !=
                                            null
                                        ? List.generate(
                                            consultantAssessmentData[index]
                                                .consultantAssessment!
                                                .muscleAssessments
                                                .length,
                                            (index2) =>
                                                consultantAssessmentData[index]
                                                    .consultantAssessment!
                                                    .muscleAssessments[index2]
                                                    .displayConditions
                                                    .toString(),
                                          ).toString()
                                        : 'No data',
                                  ),

                                  Divider(thickness: 1, color: Colors.black),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: CustomText(
                                      text: 'Diagnosis & Treament',
                                      fontSize: 14,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),

                                  RowText(
                                    firstText: 'Final Diagnosis',
                                    secondText:
                                        consultantAssessmentData[index]
                                                .consultantAssessment !=
                                            null
                                        ? consultantAssessmentData[index]
                                              .consultantAssessment!
                                              .displayFinalDiagnosis
                                        : 'No data',
                                  ),

                                  RowText(
                                    firstText: 'Duration',
                                    secondText:
                                        consultantAssessmentData[index]
                                                .consultantAssessment !=
                                            null
                                        ? consultantAssessmentData[index]
                                              .consultantAssessment!
                                              .sessionDuration
                                              .toString()
                                        : 'No data',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : Center(child: CustomText(text: 'text')),
          );
        }
        if (state is ConsultantLoadedFromRecordsState) {
          consultantAssessments = state.model;
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
              title: Text('Consultant Assessments'),
              automaticallyImplyLeading: false,
            ),
            backgroundColor: AppColors.bgColor,
            body: ListView(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 10.h,
                bottom: 60.h,
              ),
              children: [
                CustomText(
                  text: 'Consultant Assessments',
                  fontSize: 20,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 30.h),
                Card(
                  color: AppColors.secondaryColor,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    //   height: 404.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CustomText(
                            text: 'Clinical Finding',
                            fontSize: 14,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        RowText(
                          firstText: 'Diagnosis',
                          secondText: consultantAssessments!
                              .clinicalFindings!
                              .displayDiagnosis
                              .toString(),
                        ),
                        SizedBox(height: 7.h),

                        RowText(
                          firstText: 'Note',
                          secondText: consultantAssessments!
                              .clinicalFindings!
                              .displayNote
                              .toString(),
                        ),
                        Divider(thickness: 1, color: Colors.black),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CustomText(
                            text: 'Advice',
                            fontSize: 14,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        RowText(
                          firstText: 'Investigations Done',
                          secondText: consultantAssessments!
                              .advice!
                              .displayInvestigationsDone
                              .toString(),
                        ),
                        SizedBox(height: 7.h),

                        RowText(
                          firstText: 'Other Investigations Advice',
                          secondText: consultantAssessments!
                              .advice!
                              .displayOtherInvestigationsAdvice
                              .toString(),
                        ),

                        Divider(thickness: 1, color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CustomText(
                            text: 'General Therapeutic Prescription',
                            fontSize: 14,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        RowText(
                          firstText: 'Advanced Techniques',
                          secondText: consultantAssessments!
                              .generalTherapeuticPrescription!
                              .displayAdvancedTechniques
                              .toString(),
                        ),
                        SizedBox(height: 7.h),

                        RowText(
                          firstText: 'Anti Inflammatory Modalities',
                          secondText: consultantAssessments!
                              .generalTherapeuticPrescription!
                              .displayAntiInflammatoryModalities
                              .toString(),
                        ),

                        SizedBox(height: 7.h),

                        RowText(
                          firstText: 'Electrotherapy',
                          secondText: consultantAssessments!
                              .generalTherapeuticPrescription!
                              .displayElectrotherapy
                              .toString(),
                        ),
                        RowText(
                          firstText: 'Medications',
                          secondText: consultantAssessments!
                              .generalTherapeuticPrescription!
                              .displayMedications
                              .toString(),
                        ),
                        RowText(
                          firstText: 'Thermo Cryotherapy',
                          secondText: consultantAssessments!
                              .generalTherapeuticPrescription!
                              .displayThermoCryotherapy
                              .toString(),
                        ),
                        RowText(
                          firstText: 'Topicals',
                          secondText: consultantAssessments!
                              .generalTherapeuticPrescription!
                              .displayTopicals
                              .toString(),
                        ),
                        Divider(thickness: 1, color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CustomText(
                            text: 'Muscle Assessments',
                            fontSize: 14,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        ...List.generate(
                          (consultantAssessments!.muscleAssessments.length),
                          (index) {
                            return Column(
                              children: [
                                RowText(
                                  firstText: 'Other Treatment',
                                  secondText: consultantAssessments!
                                      .muscleAssessments[index]
                                      .displayOtherTreatment
                                      .toString(),
                                ),
                                RowText(
                                  firstText: 'Muscle',
                                  secondText: consultantAssessments!
                                      .muscleAssessments[index]
                                      .displayMuscle
                                      .toString(),
                                ),
                                RowText(
                                  firstText: 'Manual Treatment',
                                  secondText: consultantAssessments!
                                      .muscleAssessments[index]
                                      .displayManualTreatment
                                      .toString(),
                                ),
                                RowText(
                                  firstText: 'Condition Status',
                                  secondText: consultantAssessments!
                                      .muscleAssessments[index]
                                      .conditionStatus
                                      .toString(),
                                ),

                                RowText(
                                  firstText: 'ByDefaultExercise',
                                  secondText: consultantAssessments!
                                      .muscleAssessments[index]
                                      .byDefaultExercises
                                      .toString(),
                                ),
                              ],
                            );
                          },
                        ),
                        Divider(thickness: 1, color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CustomText(
                            text: 'Session Settings',
                            fontSize: 14,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        RowText(
                          firstText: 'PrescribedSessionDuration',
                          secondText: consultantAssessments!
                              .sessionSettings!
                              .displayPrescribedSessionDuration!
                              .toString(),
                        ),
                        RowText(
                          firstText: 'Session Settings',
                          secondText: consultantAssessments!
                              .sessionSettings!
                              .displayPrescribedSessionDuration!
                              .toString(),
                        ),
                        Divider(thickness: 1, color: Colors.black),

                        RowText(
                          firstText: 'Manual Muscle Testing',
                          secondText: consultantAssessments!
                              .manualMuscleTesting!
                              .toString(),
                        ),
                        RowText(
                          firstText: 'Selected Packages',
                          secondText: consultantAssessments!.selectedPackages!
                              .toString(),
                        ),
                        RowText(
                          firstText: 'Special Examination',
                          secondText: consultantAssessments!
                              .specialTestsExamination!
                              .toString(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ConsultantLoadingState) {
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
