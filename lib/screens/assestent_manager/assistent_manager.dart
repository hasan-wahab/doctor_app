import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_styles/app_colors.dart';
import '../../models/current_patient_model.dart';
import '../../widgets/custom_text.dart';

class AssistantManagerScreen extends StatefulWidget {
  const AssistantManagerScreen({super.key});

  @override
  State<AssistantManagerScreen> createState() => _AssistantManagerScreenState();
}

class _AssistantManagerScreenState extends State<AssistantManagerScreen> {
  CurrentPatientModel? currentPatientData;
  var amAssessments;
  @override
  void didChangeDependencies() {
    Map<String, dynamic> data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if (data != null) {
      currentPatientData = data['data'];
      amAssessments = data['amAssessments'];
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
        title: Text('Assistant manager'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        children: [
          CustomText(
            text: 'Assistant Manager Assessment',
            fontSize: 20,
            color: AppColors.primaryColor,
          ),

          currentPatientData != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    currentPatientData!.patient!.visits.length,

                    (index) {
                      var assistantManager =
                          currentPatientData!.patient!.visits[index];
                      if (assistantManager.assistantManager != null) {
                        return Card(
                          margin: EdgeInsets.only(top: 10.h),
                          color: AppColors.secondaryColor,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 20.h,
                            ),
                            height: 420.h,
                            width: 360.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _text(
                                  firstText: 'Visit Date #',
                                  secondText:
                                      assistantManager.createdAt
                                          .toString()
                                          .isEmpty
                                      ? 'no data'
                                      : DateAndTimeFormater.dateFormat(
                                          assistantManager.createdAt.toString(),
                                        ),
                                ),
                                _text(
                                  firstText: 'AM Name',
                                  secondText:
                                      assistantManager
                                          .assistantManager!
                                          .name
                                          .isEmpty
                                      ? 'no data'
                                      : assistantManager.assistantManager!.name,
                                ),
                                _text(
                                  firstText: 'Consultant',
                                  secondText:
                                      assistantManager.consultant!.name.isEmpty
                                      ? 'no data'
                                      : assistantManager.consultant!.name,
                                ),

                                _text(
                                  firstText: 'Occupation',
                                  secondText:
                                      assistantManager
                                          .amAssessment!
                                          .occupation ??
                                      'no data',
                                ),
                                _text(
                                  firstText: 'Chief Complaint',
                                  secondText:
                                      assistantManager
                                          .amAssessment!
                                          .chiefComplaint
                                          .isEmpty
                                      ? 'no data'
                                      : assistantManager
                                            .amAssessment!
                                            .chiefComplaint,
                                ),
                                _text(
                                  firstText: 'Complaint Onset',
                                  secondText:
                                      assistantManager
                                          .amAssessment!
                                          .complaintOnset ??
                                      'no data',
                                ),
                                _text(
                                  firstText: 'Pain Severity',
                                  secondText:
                                      assistantManager
                                          .amAssessment!
                                          .painSeverity ??
                                      'no data',
                                ),
                                _text(
                                  firstText: 'Pain Type',
                                  secondText:
                                      assistantManager.amAssessment!.painType ??
                                      'no data',
                                ),

                                _text(
                                  firstText: 'Pain Location',
                                  secondText:
                                      assistantManager
                                          .amAssessment!
                                          .painLocation ??
                                      'no data',
                                ),
                                _text(
                                  firstText: 'Pain Radiation',
                                  secondText:
                                      assistantManager
                                          .amAssessment!
                                          .painRadiation ??
                                      'no data',
                                ),
                                _text(
                                  firstText: 'Aggravating Factors',
                                  secondText:
                                      assistantManager
                                          .amAssessment!
                                          .aggravatingFactors ??
                                      'no data',
                                ),
                                _text(
                                  firstText: 'Relieving Factors',
                                  secondText:
                                      assistantManager
                                          .amAssessment!
                                          .relievingFactors ??
                                      'no data',
                                ),
                                _text(
                                  firstText: 'Functional Impact',
                                  secondText:
                                      assistantManager
                                          .amAssessment!
                                          .functionalImpact ??
                                      'no data',
                                ),

                                _text(
                                  firstText: 'Consent',
                                  buttonText:
                                      assistantManager
                                              .amAssessment!
                                              .consentGiven ==
                                          true
                                      ? 'Given'
                                      : 'Not Given',
                                  buttonColor: Colors.yellow,
                                ),

                                CustomText(
                                  text: 'Red Flags',
                                  color: Colors.red,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 50.h,
                                      width: 310.w,
                                      child: CustomText(
                                        maxLines: 5,
                                        text: assistantManager
                                            .amAssessment!
                                            .redFlags
                                            .toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Center(child: Container());
                    },
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (amAssessments.assistantManager != null)
                      Card(
                        margin: EdgeInsets.only(top: 10.h),
                        color: AppColors.secondaryColor,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 20.h,
                          ),
                          height: 420.h,
                          width: 360.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _text(
                                firstText: 'Visit Date ',
                                secondText:
                                    amAssessments.createdAt.toString().isEmpty
                                    ? 'no data'
                                    : DateAndTimeFormater.dateFormat(
                                        amAssessments.createdAt.toString(),
                                      ),
                              ),
                              _text(
                                firstText: 'AM Name',
                                secondText:
                                    amAssessments.assistantManager!.name.isEmpty
                                    ? 'no data'
                                    : amAssessments.assistantManager!.name,
                              ),
                              _text(
                                firstText: 'Consultant',
                                secondText:
                                    amAssessments.consultant!.name.isEmpty
                                    ? 'no data'
                                    : amAssessments.consultant!.name,
                              ),

                              _text(
                                firstText: 'Occupation',
                                secondText:
                                    amAssessments.amAssessment!.occupation ??
                                    'no data',
                              ),
                              _text(
                                firstText: 'Chief Complaint',
                                secondText:
                                    amAssessments
                                        .amAssessment!
                                        .chiefComplaint
                                        .isEmpty
                                    ? 'no data'
                                    : amAssessments
                                          .amAssessment!
                                          .chiefComplaint,
                              ),
                              _text(
                                firstText: 'Complaint Onset',
                                secondText:
                                    amAssessments
                                        .amAssessment!
                                        .complaintOnset ??
                                    'no data',
                              ),
                              _text(
                                firstText: 'Pain Severity',
                                secondText:
                                    amAssessments.amAssessment!.painSeverity ??
                                    'no data',
                              ),
                              _text(
                                firstText: 'Pain Type',
                                secondText:
                                    amAssessments.amAssessment!.painType ??
                                    'no data',
                              ),

                              _text(
                                firstText: 'Pain Location',
                                secondText:
                                    amAssessments.amAssessment!.painLocation ??
                                    'no data',
                              ),
                              _text(
                                firstText: 'Pain Radiation',
                                secondText:
                                    amAssessments.amAssessment!.painRadiation ??
                                    'no data',
                              ),
                              _text(
                                firstText: 'Aggravating Factors',
                                secondText:
                                    amAssessments
                                        .amAssessment!
                                        .aggravatingFactors ??
                                    'no data',
                              ),
                              _text(
                                firstText: 'Relieving Factors',
                                secondText:
                                    amAssessments
                                        .amAssessment!
                                        .relievingFactors ??
                                    'no data',
                              ),
                              _text(
                                firstText: 'Functional Impact',
                                secondText:
                                    amAssessments
                                        .amAssessment!
                                        .functionalImpact ??
                                    'no data',
                              ),

                              _text(
                                firstText: 'Consent',
                                buttonText:
                                    amAssessments.amAssessment!.consentGiven ==
                                        true
                                    ? 'Given'
                                    : 'Not Given',
                                buttonColor: Colors.yellow,
                              ),

                              CustomText(text: 'Red Flags', color: Colors.red),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50.h,
                                    width: 310.w,
                                    child: CustomText(
                                      maxLines: 5,
                                      text: amAssessments.amAssessment!.redFlags
                                          .toString(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Center(child: Container()),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _text({
    required String firstText,
    String? secondText,
    String? buttonText,
    Color? buttonColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomText(text: firstText, color: AppColors.primaryColor),
        ),
        Expanded(
          child: secondText != null
              ? CustomText(text: secondText, align: TextAlign.start)
              : Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 1.h,
                        ),
                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                          color: buttonColor ?? AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: CustomText(
                          maxLines: 2,
                          text: buttonText!,
                          color: buttonColor == Colors.yellow
                              ? AppColors.firstTextBlackColor
                              : AppColors.textWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
