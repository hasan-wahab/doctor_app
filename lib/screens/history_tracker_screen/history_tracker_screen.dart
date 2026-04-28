import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/screens/history_tracker_screen/bloc/history_tracker_bloc.dart';
import 'package:doctor_app/screens/history_tracker_screen/bloc/history_tracker_state.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/api_service/base_api/base_api_impl.dart';
import '../../data/local_storage/local_curd_base/local_curd_impl.dart';
import '../../data/models/history_traker_model.dart';
import '../../repos/history_tracker_repo/history_tracker_repo_Impl.dart';
import '../../widgets/custom_text.dart';

class HistoryTrackerScreen extends StatefulWidget {
  const HistoryTrackerScreen({super.key});

  @override
  State<HistoryTrackerScreen> createState() => _HistoryTrackerScreenState();
}

class _HistoryTrackerScreenState extends State<HistoryTrackerScreen> {
  HistoryTrackerModel? historyTrackerModel;

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return BlocConsumer<HistoryTrackerBloc, HistoryTrackerState>(
      listener: (context, state) {
        if (state is HistoryTrackerLoadingState) {
          isLoading = true;
        } else if (state is HistoryTrackerMessageState) {
          isLoading = false;
          AppMsg.showSnackBar(context, message: state.message);
        } else if (state is HistoryTrackerGetState) {
          isLoading = false;

          historyTrackerModel = state.historyTrackerModel;
        }
      },
      builder: (context, state) {
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
            title: Text('History Tracker'),
            automaticallyImplyLeading: false,
          ),
          backgroundColor: AppColors.bgColor,

          body: isLoading != true && historyTrackerModel != null
              ? ListView(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 10.h,
                    bottom: 60.h,
                  ),
                  children: [
                    CustomText(
                      text: 'History Tracker',
                      fontSize: 20,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: 20.h),

                    ...List.generate((1), (index) {
                      return Card(
                        color: AppColors.secondaryColor,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          //  height: 404.h,
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
                                          MediaQuery.sizeOf(context).width /
                                              1.3 -
                                          15,
                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          CustomText(text: ''),
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
                                  text: 'Patient Information',
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                ),
                              ),

                              _text(
                                firstText: 'Name',
                                secondText: historyTrackerModel!
                                    .patientInformation!
                                    .displayName,
                              ),

                              _text(
                                firstText: 'Age',
                                secondText: historyTrackerModel!
                                    .patientInformation!
                                    .displayAge,
                              ),

                              _text(
                                firstText: 'Occupation',
                                secondText: historyTrackerModel!
                                    .patientInformation!
                                    .displayOccupation,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: CustomText(
                                  text: 'Chief Complaint',
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                ),
                              ),

                              _text(
                                firstText: 'Deviation',
                                secondText: historyTrackerModel!
                                    .chiefComplaint!
                                    .displayDeviation,
                              ),

                              _text(
                                firstText: 'Complaints',
                                secondText: historyTrackerModel!
                                    .chiefComplaint
                                    ?.complaints
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Side Affected',
                                secondText: historyTrackerModel!
                                    .chiefComplaint!
                                    .sideAffected
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Pain Relieve',
                                secondText: historyTrackerModel!
                                    .aggravatingFactors!
                                    .factors
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Symptoms',
                                secondText: historyTrackerModel!
                                    .associatedSymptoms!
                                    .symptoms
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Bladder Or Sexual Worsening',
                                secondText: historyTrackerModel!
                                    .forMenOnly!
                                    .displayBladderOrSexualWorsening
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Genital Numbness',
                                secondText: historyTrackerModel!
                                    .forMenOnly!
                                    .displayGenitalNumbness
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Urine Leakage',
                                secondText: historyTrackerModel!
                                    .forMenOnly!
                                    .displayUrineLeakage
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Urination Pain',
                                secondText: historyTrackerModel!
                                    .forMenOnly!
                                    .displayUrinationPain
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Nocturia',
                                secondText: historyTrackerModel!
                                    .forMenOnly!
                                    .displayNocturia
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Limited Activities',
                                secondText: historyTrackerModel!
                                    .functionalLimitations!
                                    .limitedActivities
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Analysis',
                                secondText: historyTrackerModel!
                                    .gaitAnalysis!
                                    .displayAnalysis,
                              ),

                              _text(
                                firstText: 'Movements',
                                secondText: historyTrackerModel!
                                    .movementRelatedPain!
                                    .movements
                                    .toString(),
                              ),

                              _text(
                                firstText: 'How Did It Start',
                                secondText: historyTrackerModel!
                                    .onsetAndCause!
                                    .displayHowDidItStart
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Possible Cause',
                                secondText: historyTrackerModel!
                                    .onsetAndCause!
                                    .possibleCause
                                    .toString(),
                              ),
                              Divider(thickness: 1, color: Colors.black),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: CustomText(
                                  text: 'Pain Details',
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                ),
                              ),

                              _text(
                                firstText: 'Duration',
                                secondText: historyTrackerModel!
                                    .painDetails!
                                    .displayDuration
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Pain Intensity Vas',
                                secondText: historyTrackerModel!
                                    .painDetails!
                                    .displayPainIntensity
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Pain Timing',
                                secondText: historyTrackerModel!
                                    .painDetails!
                                    .painTiming
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Type Of Pain',
                                secondText: historyTrackerModel!
                                    .painDetails!
                                    .typeOfPain
                                    .toString(),
                              ),
                              Divider(thickness: 1, color: Colors.black),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: CustomText(
                                  text: 'Past Medical History',
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                ),
                              ),

                              _text(
                                firstText: 'Surgical History',
                                secondText: historyTrackerModel!
                                    .pastMedicalHistory!
                                    .displaySurgicalHistory
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Medical History',
                                secondText: historyTrackerModel!
                                    .pastMedicalHistory!
                                    .medicalHistory
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Medical History Details',
                                secondText: historyTrackerModel!
                                    .pastMedicalHistory!
                                    .medicalHistoryDetails
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Previous Treatments',
                                secondText: historyTrackerModel!
                                    .pastMedicalHistory!
                                    .previousTreatments
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Treatment Responses',
                                secondText: historyTrackerModel!
                                    .pastMedicalHistory!
                                    .treatmentResponses
                                    .values
                                    .toString(),
                              ),

                              _text(
                                firstText: 'Pain Location',
                                secondText: historyTrackerModel!
                                    .painLocation!
                                    .painLocation
                                    .toString(),
                              ),
                              _text(
                                firstText: 'Investigations Done',
                                secondText: historyTrackerModel!
                                    .previousInvestigations!
                                    .investigationsDone
                                    .toString(),
                              ),
                              _text(
                                firstText: 'Red Flags',
                                buttonText: historyTrackerModel!.redFlags!.flags
                                    .toString(),
                              ),
                              _text(
                                firstText: 'Radiating Status',
                                buttonText: historyTrackerModel!
                                    .radiatingPain!
                                    .displayRadiatingStatus
                                    .toString(),
                              ),
                              _text(
                                firstText: 'Radiating Side',
                                buttonText: historyTrackerModel!
                                    .radiatingPain!
                                    .displayRadiationSide
                                    .toString(),
                              ),
                              _text(
                                firstText: 'Radiating Path',
                                buttonText: historyTrackerModel!
                                    .radiatingPain!
                                    .radiationPath
                                    .toString(),
                              ),
                              _text(
                                firstText: 'Limited Activities',
                                buttonText: historyTrackerModel!
                                    .functionalLimitations!
                                    .limitedActivities
                                    .toString(),
                              ),
                              _text(
                                firstText: 'How Did It Start',
                                buttonText: historyTrackerModel!
                                    .onsetAndCause!
                                    .displayHowDidItStart
                                    .toString(),
                              ),
                              _text(
                                firstText: 'Possible Cause',
                                buttonText: historyTrackerModel!
                                    .onsetAndCause!
                                    .possibleCause
                                    .toString(),
                              ),
                              _text(
                                firstText: 'Investigations Done',
                                buttonText: historyTrackerModel!
                                    .previousInvestigations!
                                    .investigationsDone
                                    .toString(),
                              ),
                              _text(
                                firstText: 'Display Analysis',
                                buttonText: historyTrackerModel!
                                    .gaitAnalysis!
                                    .displayAnalysis!
                                    .toString(),
                              ),
                              _text(
                                firstText: 'Factors',
                                buttonText: historyTrackerModel!
                                    .relievingFactors!
                                    .factors
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget _text({
  required String firstText,
  String? secondText,
  String? buttonText,
})
{
  if (secondText.toString().isNotEmpty &&
      secondText != 'No data' &&
      secondText != 'No data' &&
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
