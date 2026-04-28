import 'package:doctor_app/data/models/consultant_assesment_model.dart';
import 'package:doctor_app/screens/assessments/bloc/consultant_assesmant_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/models/current_patient_model.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    id = ModalRoute.of(context)?.settings.arguments as String?;
    context.read<ConsultantAssessmentBloc>().add(
      ConsultantAssessmentEvent(id: id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantAssessmentBloc, ConsultantAssessmentState>(
      listener: (context, state) {
        if (state is ConsultantMessageState) {
          isLoading = false;
          AppMsg.showErrorMsg(context, msg: state.message.toString());
        }
        print(state);
      },
      builder: (context, state) {
        if (state is ConsultantFromHomeLoaded) {
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

                ...List.generate(
                  (currentPatientData!.patient.visits.isNotEmpty
                      ? 1
                      : currentPatientData!.patient.visits.length),
                  (index) {
                    return Card(
                      color: AppColors.secondaryColor,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 404.h,
                        width: 350.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              height: 40.h,
                              width: 350.w,
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide()),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width / 1.3 -
                                        15,
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        CustomText(
                                          text: currentPatientData!
                                              .patient
                                              .visits[index]
                                              .consultant
                                              .name
                                              .toString(),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,

                                          child: Container(
                                            margin: EdgeInsets.only(top: 5.h),
                                            alignment: Alignment.center,
                                            height: 16.h,
                                            width: 31.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3.r),
                                              color: AppColors.primaryColor,
                                            ),
                                            child: CustomText(
                                              text: 'abds',
                                              fontSize: 12,
                                              color: AppColors.textWhiteColor,
                                            ),
                                          ),
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
                            SizedBox(height: 10.h),

                            _text(
                              firstText: 'Observation',
                              secondText: currentPatientData!
                                  .patient
                                  .visits[index]
                                  .consultantAssessment['observation_findings']
                                  .toString(),
                            ),
                            SizedBox(height: 7.h),

                            _text(
                              firstText: 'Palpation',
                              secondText: currentPatientData!
                                  .patient
                                  .visits[index]
                                  .consultantAssessment['palpation_results']
                                  .toString(),
                            ),
                            SizedBox(height: 7.h),

                            _text(
                              firstText: 'ROM',
                              secondText: currentPatientData!
                                  .patient
                                  .visits[index]
                                  .consultantAssessment['rom_assessment']
                                  .toString(),
                            ),
                            SizedBox(height: 7.h),

                            _text(
                              firstText: 'Neuro Test:',
                              secondText: currentPatientData!
                                  .patient
                                  .visits[index]
                                  .consultantAssessment['neuro_special_tests']
                                  .toString(),
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
                            SizedBox(height: 10.h),

                            _text(
                              firstText: 'Pain Relieve',
                              secondText: currentPatientData!
                                  .patient
                                  .visits[index]
                                  .consultantAssessment['med_pain_reliever']
                                  .toString(),
                            ),
                            SizedBox(height: 7.h),

                            _text(
                              firstText: 'Muscle Relaxant',
                              secondText: currentPatientData!
                                  .patient
                                  .visits[index]
                                  .consultantAssessment['med_muscle_relaxant']
                                  .toString(),
                            ),
                            SizedBox(height: 7.h),

                            _text(
                              firstText: 'Supplements',
                              secondText: currentPatientData!
                                  .patient
                                  .visits[index]
                                  .consultantAssessment['med_supplements']
                                  .toString(),
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
                            SizedBox(height: 10.h),

                            _text(
                              firstText: 'Final Diagnosis',
                              secondText: currentPatientData!
                                  .patient
                                  .visits[index]
                                  .consultantAssessment['final_diagnosis']
                                  .toString(),
                            ),
                            SizedBox(height: 7.h),

                            _text(
                              firstText: 'Frequency',
                              secondText: currentPatientData!
                                  .patient
                                  .visits[index]
                                  .consultantAssessment['freq_per_week']
                                  .toString(),
                            ),

                            SizedBox(height: 7.h),

                            _text(
                              firstText: 'Duration',
                              secondText: currentPatientData!
                                  .patient
                                  .visits[index]
                                  .consultantAssessment['duration_weeks']
                                  .toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is ConsultantLoadedState) {
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

                        _text(
                          firstText: 'Diagnosis',
                          secondText: consultantAssessments!
                              .clinicalFindings!
                              .displayDiagnosis
                              .toString(),
                        ),
                        SizedBox(height: 7.h),

                        _text(
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

                        _text(
                          firstText: 'Investigations Done',
                          secondText: consultantAssessments!
                              .advice!
                              .displayInvestigationsDone
                              .toString(),
                        ),
                        SizedBox(height: 7.h),

                        _text(
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

                        _text(
                          firstText: 'Advanced Techniques',
                          secondText: consultantAssessments!
                              .generalTherapeuticPrescription!
                              .displayAdvancedTechniques
                              .toString(),
                        ),
                        SizedBox(height: 7.h),

                        _text(
                          firstText: 'Anti Inflammatory Modalities',
                          secondText: consultantAssessments!
                              .generalTherapeuticPrescription!
                              .displayAntiInflammatoryModalities
                              .toString(),
                        ),

                        SizedBox(height: 7.h),

                        _text(
                          firstText: 'Electrotherapy',
                          secondText: consultantAssessments!
                              .generalTherapeuticPrescription!
                              .displayElectrotherapy
                              .toString(),
                        ),
                        _text(
                          firstText: 'Medications',
                          secondText: consultantAssessments!
                              .generalTherapeuticPrescription!
                              .displayMedications
                              .toString(),
                        ),
                        _text(
                          firstText: 'Thermo Cryotherapy',
                          secondText: consultantAssessments!
                              .generalTherapeuticPrescription!
                              .displayThermoCryotherapy
                              .toString(),
                        ),
                        _text(
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
                                _text(
                                  firstText: 'Other Treatment',
                                  secondText: consultantAssessments!
                                      .muscleAssessments[index]
                                      .displayOtherTreatment
                                      .toString(),
                                ),
                                _text(
                                  firstText: 'Muscle',
                                  secondText: consultantAssessments!
                                      .muscleAssessments[index]
                                      .displayMuscle
                                      .toString(),
                                ),
                                _text(
                                  firstText: 'Manual Treatment',
                                  secondText: consultantAssessments!
                                      .muscleAssessments[index]
                                      .displayManualTreatment
                                      .toString(),
                                ),
                                _text(
                                  firstText: 'Condition Status',
                                  secondText: consultantAssessments!
                                      .muscleAssessments[index]
                                      .conditionStatus
                                      .toString(),
                                ),

                                _text(
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
                        _text(
                          firstText: 'PrescribedSessionDuration',
                          secondText: consultantAssessments!
                              .sessionSettings!
                              .displayPrescribedSessionDuration!
                              .toString(),
                        ),
                        _text(
                          firstText: 'Session Settings',
                          secondText: consultantAssessments!
                              .sessionSettings!
                              .displayPrescribedSessionDuration!
                              .toString(),
                        ),
                        Divider(thickness: 1, color: Colors.black),

                        _text(
                          firstText: 'Manual Muscle Testing',
                          secondText: consultantAssessments!
                              .manualMuscleTesting!
                              .toString(),
                        ),
                        _text(
                          firstText: 'Selected Packages',
                          secondText: consultantAssessments!.selectedPackages!
                              .toString(),
                        ),
                        _text(
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

  Widget _text({
    required String firstText,
    String? secondText,
    String? buttonText,
  }) {
    if (secondText.toString().isNotEmpty &&
        secondText != 'No data' &&
        secondText != 'null' &&
        secondText != null &&
        secondText.contains("[]") == false) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: CustomText(text: firstText, fontSize: 12)),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomText(
                text: secondText,
                align: TextAlign.start,
                fontSize: 12,
                maxLines: 5,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      );
    } else if (buttonText.toString().isNotEmpty &&
        buttonText != 'No data' &&
        buttonText != 'No data' &&
        buttonText != null &&
        buttonText.contains("[]") == false) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomText(
                text: firstText,
                fontSize: 12,
                color: firstText == 'Red Flags' ? Colors.red : Colors.black,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomText(
                text: buttonText,
                align: TextAlign.start,
                fontSize: 12,
                maxLines: 5,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
