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

class AssessmentDetailScreen extends StatefulWidget {
  const AssessmentDetailScreen({super.key});

  @override
  State<AssessmentDetailScreen> createState() => _AssessmentDetailScreenState();
}

class _AssessmentDetailScreenState extends State<AssessmentDetailScreen> {
  CurrentPatientModel? currentPatientData;
  // var consultantAssessments;
  // var consultantAtIndex;

  bool isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   // Map<String, dynamic> data =
  //   //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
  //   // if (data != null) {
  //   //   currentPatientData = data['data'];
  //   //   consultantAtIndex = data['consultant'];
  //   //   print(consultantAtIndex);
  //
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    context.read<ProfileBloc>().add(MyProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          isLoading = true;
        } else if (state is MyProfileState) {
          isLoading = false;
          currentPatientData = state.currentPatientModel;
          print(currentPatientData);
        } else if (state is ProfileMessageState) {
          isLoading = false;
          AppMsg.showErrorMsg(context, msg: state.message.toString());
        }
      },
      builder: (context, state) {
        // return isLoading == true
        //     ? Scaffold(body: Center(child: Text('Something went wrong')))
        //     : Scaffold(body: Center(child: Text('Something went Yes ${currentPatientData?.patient.email}')));

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
                  title: Text('Consultant Assessments'),
                  automaticallyImplyLeading: false,
                ),
                backgroundColor: AppColors.bgColor,
                body: currentPatientData != null
                    ? ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
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
                                                    text: currentPatientData!
                                                        .patient
                                                        .visits[index]
                                                        .consultant
                                                        .name
                                                        .toString(),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,

                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                        top: 5.h,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      height: 16.h,
                                                      width: 31.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              3.r,
                                                            ),
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                      child: CustomText(
                                                        text: 'abds',
                                                        fontSize: 12,
                                                        color: AppColors
                                                            .textWhiteColor,
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
                                      Divider(
                                        thickness: 1,
                                        color: Colors.black,
                                      ),

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

                                      Divider(
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
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
                      )
                    : Center(child: CircularProgressIndicator()),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _text({
    required String firstText,
    String? secondText,
    String? buttonText,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: CustomText(text: firstText, fontSize: 12)), //
          Expanded(
            child: secondText != null
                ? CustomText(
                    text: secondText,
                    align: TextAlign.start,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  )
                : Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 1.h,
                        ),
                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: CustomText(
                          fontSize: 12,

                          text: buttonText ?? '',
                          color: AppColors.textWhiteColor,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
