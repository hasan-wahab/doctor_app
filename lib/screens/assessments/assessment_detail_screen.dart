import 'package:doctor_app/screens/assessments/bloc/consultant_assesmant_bloc.dart';
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
  ConsultantAssessmentModel? consultantAssessments;
  MuscleAssessmentModel? muscleAssessmentModel;
  SessionSettings? settingsModel;
  AdviceModel? adviceModel;
  GeneralTherapeuticPrescription? prescriptionModel;
  List<String>? selectedPackages;
  List<String>? mmt;

  String? id;
  bool isLoading = false;
  String? message;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    context.read<ConsultantAssessmentBloc>().add(
      ConsultantAssessmentEvent(id: widget.visitId),
    );
    print(
      ''''''
      ''''''
      'Isd${widget.visitId}'
      ''''''
      '''''',
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
                child:
                    isLoading == false && allConsultantAssessmentModel != null
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
                            (allConsultantAssessmentModel!.isNotEmpty
                                ? allConsultantAssessmentModel!.length
                                : 1),
                            (index) {
                              List<MuscleAssessment> muscleAssessments =
                                  allConsultantAssessmentModel![index]
                                      .muscleAssessments;
                              List<Exercise> exercies =
                                  muscleAssessments[index]
                                      .prescribedExercises
                                      .isNotEmpty
                                  ? muscleAssessments[index].prescribedExercises
                                  : [];

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  MediaQuery.sizeOf(
                                                        context,
                                                      ).width /
                                                      1.3 -
                                                  15,
                                              child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: [
                                                  CustomText(
                                                    text:
                                                        allConsultantAssessmentModel![index]
                                                            .consultant
                                                            .toString(),
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
                                        firstText: 'Assessment Id',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .assessmentId
                                                .toString(),
                                      ),
                                      RowText(
                                        firstText: 'Final Diagnosis',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .clinicalFindings!
                                                .diagnosis
                                                .toString()
                                                .toString(),
                                      ),

                                      RowText(
                                        firstText: 'Next Review Date',
                                        secondText:
                                            DateAndTimeFormater.dateFormat(
                                              allConsultantAssessmentModel![index]
                                                  .visitDate
                                                  .toString(),
                                            ),
                                      ),

                                      RowText(
                                        firstText: 'Neuro Test:',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .specialTests
                                                .toString(),
                                      ),

                                      RowText(
                                        firstText:
                                            'Manual Muscle Testing (MMT)',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .mmt
                                                .toString(),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                        ),
                                        child: CustomText(
                                          text: 'Muscle Assessment',
                                          fontSize: 14,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      RowText(
                                        firstText: 'Status',
                                        secondText: List.generate(
                                          (muscleAssessments.length),
                                          (index2) {
                                            return muscleAssessments[index2]
                                                .conditionStatus;
                                          },
                                        ).toString(),
                                      ),
                                      RowText(
                                        firstText: 'Exercise',
                                        secondText: List.generate(
                                          (exercies.length),
                                          (index2) {
                                            return exercies[index2].name
                                                .toString();
                                          },
                                        ).toString(),
                                      ),
                                      RowText(
                                        firstText: 'Dosage',
                                        secondText: List.generate(
                                          (exercies.length),
                                          (index2) {
                                            return exercies[index2].dosage
                                                .toString();
                                          },
                                        ).toString(),
                                      ),
                                      RowText(
                                        firstText: 'Default Exercise',
                                        secondText: List.generate(
                                          (muscleAssessments.length),
                                          (index2) {
                                            return muscleAssessments[index2]
                                                .defaultExercises
                                                .toString();
                                          },
                                        ).toString(),
                                      ),
                                      RowText(
                                        firstText: 'Manual Treatment',
                                        secondText: List.generate(
                                          (muscleAssessments.length),
                                          (index2) {
                                            return muscleAssessments[index2]
                                                .manualTreatment
                                                .toString();
                                          },
                                        ).toString(),
                                      ),
                                      RowText(
                                        firstText: 'Muscle',
                                        secondText: List.generate(
                                          (muscleAssessments.length),
                                          (index2) {
                                            return muscleAssessments[index2]
                                                .muscle
                                                .toString();
                                          },
                                        ).toString(),
                                      ),
                                      RowText(
                                        firstText: 'Other Treatment',
                                        secondText: List.generate(
                                          (muscleAssessments.length),
                                          (index2) {
                                            return muscleAssessments[index2]
                                                .otherTreatment;
                                          },
                                        ).toString(),
                                      ),

                                      RowText(
                                        firstText: 'MMT',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .mmt
                                                .toString(),
                                      ),
                                      RowText(
                                        firstText: 'Selected Package',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .selectedPackages
                                                .toString(),
                                      ),
                                      RowText(
                                        firstText: 'Duration',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .sessionSettings!
                                                .duration
                                                .toString(),
                                      ),
                                      RowText(
                                        firstText: 'Investigations Done',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .advice!
                                                .investigationsDone
                                                .toString(),
                                      ),
                                      RowText(
                                        firstText: 'Other Advice',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .advice!
                                                .otherAdvice
                                                .toString(),
                                      ),
                                      RowText(
                                        firstText: 'Advanced',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .prescription!
                                                .advanced
                                                .toString(),
                                      ),
                                      RowText(
                                        firstText: 'Topicals',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .prescription!
                                                .topicals
                                                .toString(),
                                      ),
                                      RowText(
                                        firstText: 'Anti Inflammatory',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .prescription!
                                                .antiInflammatory
                                                .toString(),
                                      ),
                                      RowText(
                                        firstText: 'Thermo',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .prescription!
                                                .thermo
                                                .toString(),
                                      ),
                                      RowText(
                                        firstText: 'Electrotherapy',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .prescription!
                                                .electrotherapy
                                                .toString(),
                                      ),
                                      RowText(
                                        firstText: 'Medications',
                                        secondText:
                                            allConsultantAssessmentModel![index]
                                                .prescription!
                                                .medications
                                                .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : isLoading
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
                              onTap: () =>
                                  context.read<ConsultantAssessmentBloc>().add(
                                    ConsultantAssessmentEvent(isRefresh: true),
                                  ),
                              child: Icon(Icons.refresh),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
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
            body: SafeArea(
              child: ListView(
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
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
