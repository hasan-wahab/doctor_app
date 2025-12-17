import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/current_patient_model.dart';

class AssessmentDetailScreen extends StatefulWidget {
  const AssessmentDetailScreen({super.key});

  @override
  State<AssessmentDetailScreen> createState() => _AssessmentDetailScreenState();
}

class _AssessmentDetailScreenState extends State<AssessmentDetailScreen> {
  CurrentPatientModel? currentPatientData;
  @override
  void didChangeDependencies() {
    Map<String, CurrentPatientModel> data =
        ModalRoute.of(context)?.settings.arguments
            as Map<String, CurrentPatientModel>;
    if (data != null) {
      currentPatientData = data['data'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
        centerTitle: true,
        title: Text('Assessments'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        children: [
          CustomText(
            text: 'Consultant Assessments',
            fontSize: 20,
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 30.h),
          ...List.generate((currentPatientData!.patient!.visits.length), (
            index,
          ) {
            var consultantAssessments = currentPatientData!
                .patient!
                .visits[index]
                .consultantAssessment!;
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 404.h,
              width: 350.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(width: 2, color: AppColors.primaryColor),
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
                          width: MediaQuery.sizeOf(context).width / 1.3 - 15,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              CustomText(
                                text: currentPatientData!
                                    .patient!
                                    .visits[index]
                                    .consultant!
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
                                    borderRadius: BorderRadius.circular(3.r),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomText(
                      text: 'Assessment Finding',
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  _text(
                    firstText: 'Observation',
                    secondText: consultantAssessments.observationFindings
                        .toString(),
                  ),
                  SizedBox(height: 7.h),

                  _text(
                    firstText: 'Palpation',
                    secondText: consultantAssessments.palpationResults,
                  ),
                  SizedBox(height: 7.h),

                  _text(
                    firstText: 'ROM',
                    secondText: consultantAssessments.romAssessment,
                  ),
                  SizedBox(height: 7.h),

                  _text(
                    firstText: 'Neuro Test:',
                    secondText: consultantAssessments.neuroSpecialTests,
                  ),
                  Divider(thickness: 1, color: Colors.black),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomText(
                      text: 'Medications',
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  _text(
                    firstText: 'Pain Relieve',
                    secondText: consultantAssessments.medPainReliever,
                  ),
                  SizedBox(height: 7.h),

                  _text(
                    firstText: 'Muscle Relaxant',
                    secondText: consultantAssessments.medMuscleRelaxant,
                  ),
                  SizedBox(height: 7.h),

                  _text(
                    firstText: 'Supplements',
                    secondText: consultantAssessments.medSupplements,
                  ),

                  Divider(thickness: 1, color: Colors.black),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomText(
                      text: 'Diagnosis & Treament',
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  _text(
                    firstText: 'Final Diagnosis',
                    secondText: consultantAssessments.finalDiagnosis,
                  ),
                  SizedBox(height: 7.h),

                  _text(
                    firstText: 'Frequency',
                    secondText: consultantAssessments.freqPerWeek.toString(),
                  ),
                  SizedBox(height: 7.h),

                  _text(
                    firstText: 'Duration',
                    secondText: consultantAssessments.durationWeeks.toString(),
                  ),
                ],
              ),
            );
          }),
          // SizedBox(height: 24.h),
          //
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10.w),
          //   height: 60.h,
          //   width: 350.w,
          //   decoration: BoxDecoration(
          //     border: Border.all(width: 2, color: AppColors.primaryColor),
          //     borderRadius: BorderRadius.circular(12.r),
          //   ),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: MediaQuery.sizeOf(context).width / 1.3 - 15,
          //         child: Stack(
          //           alignment: Alignment.centerLeft,
          //           children: [
          //             CustomText(text: 'Nov 29, 2025- Dr Danyal Muhammad'),
          //             Align(
          //               alignment: Alignment.topRight,
          //
          //               child: Container(
          //                 margin: EdgeInsets.only(top: 10.h),
          //                 alignment: Alignment.center,
          //                 height: 16.h,
          //                 width: 31.w,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(3.r),
          //                   color: AppColors.primaryColor,
          //                 ),
          //                 child: CustomText(
          //                   text: 'abds',
          //                   fontSize: 12,
          //                   color: AppColors.textWhiteColor,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 17.h),
          //
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10.w),
          //   height: 60.h,
          //   width: 350.w,
          //   decoration: BoxDecoration(
          //     border: Border.all(width: 2, color: AppColors.primaryColor),
          //     borderRadius: BorderRadius.circular(12.r),
          //   ),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: MediaQuery.sizeOf(context).width / 1.3 - 15,
          //         child: Stack(
          //           alignment: Alignment.centerLeft,
          //           children: [
          //             CustomText(text: 'Nov 29, 2025- Dr Danyal Muhammad'),
          //             Align(
          //               alignment: Alignment.topRight,
          //
          //               child: Container(
          //                 margin: EdgeInsets.only(top: 10.h),
          //                 alignment: Alignment.center,
          //                 height: 16.h,
          //                 width: 31.w,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(3.r),
          //                   color: AppColors.primaryColor,
          //                 ),
          //                 child: CustomText(
          //                   text: 'abds',
          //                   fontSize: 12,
          //                   color: AppColors.textWhiteColor,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 17.h),
          //
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10.w),
          //   height: 60.h,
          //   width: 350.w,
          //   decoration: BoxDecoration(
          //     border: Border.all(width: 2, color: AppColors.primaryColor),
          //     borderRadius: BorderRadius.circular(12.r),
          //   ),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: MediaQuery.sizeOf(context).width / 1.3 - 15,
          //         child: Stack(
          //           alignment: Alignment.centerLeft,
          //           children: [
          //             CustomText(text: 'Nov 29, 2025- Dr Danyal Muhammad'),
          //             Align(
          //               alignment: Alignment.topRight,
          //
          //               child: Container(
          //                 margin: EdgeInsets.only(top: 10.h),
          //                 alignment: Alignment.center,
          //                 height: 16.h,
          //                 width: 31.w,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(3.r),
          //                   color: AppColors.primaryColor,
          //                 ),
          //                 child: CustomText(
          //                   text: 'abds',
          //                   fontSize: 12,
          //                   color: AppColors.textWhiteColor,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
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
          Expanded(child: CustomText(text: firstText, fontSize: 12)),
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

                          text: buttonText!,
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
