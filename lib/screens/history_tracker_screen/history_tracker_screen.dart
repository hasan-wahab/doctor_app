import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/screens/history_tracker_screen/bloc/history_tracker_bloc.dart';
import 'package:doctor_app/screens/history_tracker_screen/bloc/history_tracker_event.dart';
import 'package:doctor_app/screens/history_tracker_screen/bloc/history_tracker_state.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/aggravating_movements_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/associated_symptoms_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/chief_complaints_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/clinical_background_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/face_eye_involvement_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/face_specific_pain_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/for_men_only_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/for_women_only_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/history_taker_patient_header.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/household_red_flags_cards.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/onset_relieving_limitations_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/pain_intensity_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/primary_pain_location_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/radiating_pain_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/regions_involved_card.dart';
import 'package:doctor_app/screens/history_tracker_screen/widgets/speech_eating_drinking_card.dart';
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
  final String? visitId;
  const HistoryTrackerScreen({super.key, this.visitId = ''});

  @override
  State<HistoryTrackerScreen> createState() => _HistoryTrackerScreenState();
}

class _HistoryTrackerScreenState extends State<HistoryTrackerScreen> {
  bool isLoading = false;
  HistoryTrackerModel? historyTrackerModel;
  ForMenOnlyModel? forMenOnlyModel;
  FaceSpecificPainModel? faceSpecificPainModel;
  FaceEyeInvolvementModel? faceEyeInvolvementModel;
  SpeechEatingDrinkingModel? speechEatingDrinkingModel;
  HouseholdWorkModel? householdWorkModel;
  ForWomenOnlyModel? forWomenOnlyModel;
  PatientInformationModel? patientInformationModel;
  PainLocationModel? painLocationModel;
  RegionInvolvedModel? regionInvolvedModel;
  ChiefComplaintModel? chiefComplaintModel;
  PainDetailsModel? painDetailsModel;
  RadiatingPainModel? radiatingPainModel;
  AssociatedSymptomsModel? associatedSymptomsModel;
  MovementRelatedPainModel? movementRelatedPainModel;
  OnsetAndCauseModel? onsetAndCauseModel;
  AggravatingFactorsModel? aggravatingFactorsModel;
  RelievingFactorsModel? relievingFactorsModel;
  FunctionalLimitationsModel? functionalLimitationsModel;
  GaitAnalysisModel? gaitAnalysisModel;
  PastMedicalHistoryModel? pastMedicalHistoryModel;
  PreviousInvestigationsModel? previousInvestigationsModel;
  RedFlagsModel? redFlagsModel;
  String? message;

  @override
  void didChangeDependencies() {

    context.read<HistoryTrackerBloc>().add(
      HistoryTrackerEvent(visitId: widget.visitId),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryTrackerBloc, HistoryTrackerState>(
      listener: (context, state) async {
        if (state is HistoryTLoadingState) {
          isLoading = true;
        }
        if (state is HistoryTrackerMessageState) {
          isLoading = false;
          message = state.message;
          AppMsg.showSnackBar(context, message: state.message);
          print(state);
        }
        if (state is HistoryTrackerGetState) {
          isLoading = false;
          historyTrackerModel = state.historyTrackerModel;
          faceSpecificPainModel = state.historyTrackerModel.faceSpecificPain;
          faceEyeInvolvementModel =
              state.historyTrackerModel.faceEyeInvolvement;
          speechEatingDrinkingModel =
              state.historyTrackerModel.speechEatingDrinking;
          householdWorkModel = state.historyTrackerModel.householdWork;
          forMenOnlyModel = state.historyTrackerModel.forMenOnly;
          forWomenOnlyModel = state.historyTrackerModel.forWomenOnly;
          patientInformationModel =
              state.historyTrackerModel.patientInformation;
          painLocationModel = state.historyTrackerModel.painLocation;
          regionInvolvedModel = state.historyTrackerModel.regionInvolved;
          chiefComplaintModel = state.historyTrackerModel.chiefComplaint;
          painDetailsModel = state.historyTrackerModel.painDetails;
          radiatingPainModel = state.historyTrackerModel.radiatingPain;
          associatedSymptomsModel =
              state.historyTrackerModel.associatedSymptoms;
          movementRelatedPainModel =
              state.historyTrackerModel.movementRelatedPain;
          onsetAndCauseModel = state.historyTrackerModel.onsetAndCause;
          aggravatingFactorsModel =
              state.historyTrackerModel.aggravatingFactors;
          relievingFactorsModel = state.historyTrackerModel.relievingFactors;
          functionalLimitationsModel =
              state.historyTrackerModel.functionalLimitations;
          gaitAnalysisModel = state.historyTrackerModel.gaitAnalysis;
          pastMedicalHistoryModel =
              state.historyTrackerModel.pastMedicalHistory;
          previousInvestigationsModel =
              state.historyTrackerModel.previousInvestigations;
          redFlagsModel = state.historyTrackerModel.redFlags;
        }
      },
      child: BlocBuilder<HistoryTrackerBloc, HistoryTrackerState>(
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
              title: Text('History Taker'),
              automaticallyImplyLeading: false,
            ),
            backgroundColor: AppColors.bgColor,

            body: historyTrackerModel != null
                ? ListView(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 10.h,
                      bottom: 60.h,
                    ),
                    children: [
                      HistoryTakerPatientHeader(
                        patientName: patientInformationModel?.displayName ?? '',
                        age: patientInformationModel?.displayAge ?? '',
                        visitId: widget.visitId.toString(),
                        occupation:
                            patientInformationModel?.displayOccupation ?? '',
                      ),
                      PrimaryPainLocationCard(
                        painLocation: painLocationModel?.painLocation ?? [],
                      ),
                      RegionsInvolvedCard(
                        regions: regionInvolvedModel?.region ?? [],
                        sideAffected: regionInvolvedModel?.sideAffected ?? [],
                        deviation: regionInvolvedModel?.deviation ?? '',
                      ),

                      ChiefComplaintsCard(
                        chiefComplaints: chiefComplaintModel?.complaints ?? [],
                        sideAffected: chiefComplaintModel?.sideAffected ?? [],
                        deviation: chiefComplaintModel?.deviation ?? '',
                      ),
                      PainIntensityCard(
                        painIntensity:
                            painDetailsModel?.painIntensityVas.toString() ?? '',
                        painTiming: painDetailsModel?.painTiming ?? [],
                        typeOfPain: painDetailsModel?.typeOfPain ?? [],
                        painPattern: painDetailsModel?.painPattern ?? '',
                        duration: painDetailsModel?.duration ?? '',
                      ),
                      AggravatingMovementsCard(
                        rows: movementRelatedPainModel?.movements ?? [],
                      ),
                      OnsetRelievingLimitationsCard(
                        howStart: onsetAndCauseModel?.howDidItStart ?? '',
                        aggravatingFactors:
                            aggravatingFactorsModel?.factors ?? [],
                        functionalLimitations:
                            functionalLimitationsModel?.limitedActivities ?? [],
                        possibleCause: onsetAndCauseModel?.possibleCause ?? [],
                        relievingFactors: relievingFactorsModel?.factors ?? [],
                        analysis: gaitAnalysisModel?.analysis ?? '',
                      ),
                      ClinicalBackgroundCard(
                        medicalHistory:
                            pastMedicalHistoryModel?.medicalHistory ?? [],
                        medicalHistoryDetails:
                            pastMedicalHistoryModel?.medicalHistoryDetails ??
                            [],

                        surgicalHistory:
                            pastMedicalHistoryModel?.surgicalHistory ?? '',
                        treatmentResponses:
                            pastMedicalHistoryModel?.treatmentResponses ??
                            <String, String>{},
                        previousTreatments:
                            pastMedicalHistoryModel?.previousTreatments ?? [],
                        investigationsDone:
                            previousInvestigationsModel?.investigationsDone ??
                            [],
                      ),
                      ForWomenOnlyCard(
                        marriedSince: forWomenOnlyModel?.marriedSince ?? '',
                        hasChildren: forWomenOnlyModel?.hasChildren ?? '',
                        specialChild: forWomenOnlyModel?.specialChild ?? '',
                        isPregnant: forWomenOnlyModel?.isPregnant ?? '',
                        pregnancyType: forWomenOnlyModel?.pregnancyType ?? '',
                        previousPregnancy:
                            forWomenOnlyModel?.previousPregnancy ?? '',
                        deliveryType: forWomenOnlyModel?.deliveryType ?? '',
                        cycleRegular: forWomenOnlyModel?.cycleRegular ?? '',
                        cycleDescribe: forWomenOnlyModel?.cycleDescribe ?? '',
                        periodDiscomfort:
                            forWomenOnlyModel?.periodDiscomfort ?? '',
                        periodPainDescribe:
                            forWomenOnlyModel?.periodPainDescribe ?? '',
                        gyneConditions: forWomenOnlyModel?.gyneConditions ?? '',
                        gyneDescribe: forWomenOnlyModel?.gyneDescribe ?? '',
                        intercoursePain:
                            forWomenOnlyModel?.intercoursePain ?? '',
                        hasIud: forWomenOnlyModel?.hasIud ?? '',
                        urineLeakage: forWomenOnlyModel?.urineLeakage ?? '',
                        nocturia: forWomenOnlyModel?.nocturia ?? '',
                      ),
                      ForMenOnlyCard(
                        bladderOrSexualWorsening:
                            forMenOnlyModel?.bladderOrSexualWorsening ?? '',
                        genitalNumbness: forMenOnlyModel?.genitalNumbness ?? '',
                        nocturia: forMenOnlyModel?.nocturia ?? '',
                        urineLeakage: forMenOnlyModel?.urineLeakage ?? '',
                        urinationPain: forMenOnlyModel?.urinationPain ?? '',
                      ),
                      RadiatingPainCard(
                        status: radiatingPainModel?.radiatingStatus ?? '',
                        radiationPath: radiatingPainModel?.radiationPath ?? [],
                        radiationSide: radiatingPainModel?.radiationSide ?? '',
                      ),
                      AssociatedSymptomsCard(
                        symptoms: associatedSymptomsModel?.symptoms ?? [],
                      ),
                      FaceSpecificPainCard(
                        intensity: faceSpecificPainModel?.intensity ?? 0,
                        painPresent: faceSpecificPainModel?.painPresent ?? '',
                        location: faceSpecificPainModel?.location ?? [],
                      ),
                      SpeechEatingDrinkingCard(
                        assessment: speechEatingDrinkingModel?.assessment ?? [],
                      ),
                      FaceEyeInvolvementCard(
                        eyeClosureFully:
                            faceEyeInvolvementModel?.eyeClosureFully ?? '',
                        eyeClosurePercent:
                            faceEyeInvolvementModel?.eyeClosurePercent ?? 0,
                        eyeDryness: faceEyeInvolvementModel?.eyeDryness ?? '',
                        eyeDrynessPercent:
                            faceEyeInvolvementModel?.eyeDrynessPercent ?? 0,
                      ),
                      HouseholdWorkCard(
                        tasks: historyTrackerModel?.householdWork?.tasks ?? [],
                        status:
                            historyTrackerModel?.householdWork?.status ?? '',
                      ),
                      RedFlagsCard(flags: redFlagsModel?.flags ?? []),
                      // children: [
                      //   CustomText(
                      //     text: 'History Tracker',
                      //     fontSize: 20,
                      //     color: AppColors.primaryColor,
                      //   ),
                      //   SizedBox(height: 20.h),
                      //
                      //   ...List.generate((1), (index) {
                      //     return Card(
                      //       color: AppColors.secondaryColor,
                      //       child: Container(
                      //         margin: EdgeInsets.only(bottom: 20),
                      //         //  height: 404.h,
                      //         width: 350.w,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(12.r),
                      //         ),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(
                      //               padding: EdgeInsets.symmetric(
                      //                 horizontal: 10.w,
                      //               ),
                      //               height: 40.h,
                      //               width: 350.w,
                      //               decoration: BoxDecoration(
                      //                 border: Border(bottom: BorderSide()),
                      //               ),
                      //               child: Row(
                      //                 children: [
                      //                   SizedBox(
                      //                     width:
                      //                         MediaQuery.sizeOf(context).width /
                      //                             1.3 -
                      //                         15,
                      //                     child: Stack(
                      //                       alignment: Alignment.centerLeft,
                      //                       children: [
                      //                         CustomText(text: ''),
                      //                         Align(
                      //                           alignment: Alignment.topRight,
                      //
                      //                           child: Container(
                      //                             margin: EdgeInsets.only(
                      //                               top: 5.h,
                      //                             ),
                      //                             alignment: Alignment.center,
                      //                             height: 16.h,
                      //                             width: 31.w,
                      //                             decoration: BoxDecoration(
                      //                               borderRadius:
                      //                                   BorderRadius.circular(
                      //                                     3.r,
                      //                                   ),
                      //                               color: AppColors.primaryColor,
                      //                             ),
                      //                             child: CustomText(
                      //                               text: 'abds',
                      //                               fontSize: 12,
                      //                               color:
                      //                                   AppColors.textWhiteColor,
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             SizedBox(height: 10.h),
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 10.0,
                      //               ),
                      //               child: CustomText(
                      //                 text: 'Patient Information',
                      //                 fontSize: 14,
                      //                 color: AppColors.primaryColor,
                      //               ),
                      //             ),
                      //             patientInformationModel != null
                      //                 ? _text(
                      //                     firstText: 'Name',
                      //                     secondText: patientInformationModel!
                      //                         .displayName,
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             patientInformationModel != null
                      //                 ? _text(
                      //                     firstText: 'Age',
                      //                     secondText:
                      //                         patientInformationModel!.displayAge,
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             patientInformationModel != null
                      //                 ? _text(
                      //                     firstText: 'Occupation',
                      //                     secondText: patientInformationModel!
                      //                         .displayOccupation,
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 10.0,
                      //               ),
                      //               child: CustomText(
                      //                 text: 'Chief Complaint',
                      //                 fontSize: 14,
                      //                 color: AppColors.primaryColor,
                      //               ),
                      //             ),
                      //
                      //             chiefComplaintModel != null
                      //                 ? _text(
                      //                     firstText: 'Deviation',
                      //                     secondText: chiefComplaintModel!
                      //                         .displayDeviation,
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             chiefComplaintModel != null
                      //                 ? _text(
                      //                     firstText: 'Complaints',
                      //                     secondText: chiefComplaintModel!
                      //                         .complaints
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             chiefComplaintModel != null
                      //                 ? _text(
                      //                     firstText: 'Side Affected',
                      //                     secondText: chiefComplaintModel!
                      //                         .sideAffected
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             aggravatingFactorsModel != null
                      //                 ? _text(
                      //                     firstText: 'Factors',
                      //                     secondText: aggravatingFactorsModel!
                      //                         .factors
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             associatedSymptomsModel != null
                      //                 ? _text(
                      //                     firstText: 'Symptoms',
                      //                     secondText: associatedSymptomsModel!
                      //                         .symptoms
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             forMenOnlyModel != null
                      //                 ? _text(
                      //                     firstText:
                      //                         'Bladder Or Sexual Worsening',
                      //                     secondText: forMenOnlyModel!
                      //                         .displayBladderOrSexualWorsening
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             forMenOnlyModel != null
                      //                 ? _text(
                      //                     firstText: 'Genital Numbness',
                      //                     secondText: forMenOnlyModel!
                      //                         .displayGenitalNumbness
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             forMenOnlyModel != null
                      //                 ? _text(
                      //                     firstText: 'Urine Leakage',
                      //                     secondText: forMenOnlyModel!
                      //                         .displayUrineLeakage
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             forMenOnlyModel != null
                      //                 ? _text(
                      //                     firstText: 'Urination Pain',
                      //                     secondText: forMenOnlyModel!
                      //                         .displayUrinationPain
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             forMenOnlyModel != null
                      //                 ? _text(
                      //                     firstText: 'Nocturia',
                      //                     secondText: forMenOnlyModel!
                      //                         .displayNocturia
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             functionalLimitationsModel != null
                      //                 ? _text(
                      //                     firstText: 'Limited Activities',
                      //                     secondText: functionalLimitationsModel!
                      //                         .limitedActivities
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             gaitAnalysisModel != null
                      //                 ? _text(
                      //                     firstText: 'Analysis',
                      //                     secondText:
                      //                         gaitAnalysisModel!.displayAnalysis,
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             movementRelatedPainModel != null
                      //                 ? _text(
                      //                     firstText: 'Movements',
                      //                     secondText: movementRelatedPainModel!
                      //                         .movements
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             onsetAndCauseModel != null
                      //                 ? _text(
                      //                     firstText: 'How Did It Start',
                      //                     secondText: onsetAndCauseModel!
                      //                         .displayHowDidItStart
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             onsetAndCauseModel != null
                      //                 ? _text(
                      //                     firstText: 'Possible Cause',
                      //                     secondText: onsetAndCauseModel!
                      //                         .possibleCause
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             Divider(thickness: 1, color: Colors.black),
                      //
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 10.0,
                      //               ),
                      //               child: CustomText(
                      //                 text: 'Pain Details',
                      //                 fontSize: 14,
                      //                 color: AppColors.primaryColor,
                      //               ),
                      //             ),
                      //
                      //             painDetailsModel != null
                      //                 ? _text(
                      //                     firstText: 'Duration',
                      //                     secondText: painDetailsModel!
                      //                         .displayDuration
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             painDetailsModel != null
                      //                 ? _text(
                      //                     firstText: 'Pain Intensity Vas',
                      //                     secondText: painDetailsModel!
                      //                         .displayPainIntensity
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             painDetailsModel != null
                      //                 ? _text(
                      //                     firstText: 'Pain Timing',
                      //                     secondText: painDetailsModel!.painTiming
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             painDetailsModel != null
                      //                 ? _text(
                      //                     firstText: 'Type Of Pain',
                      //                     secondText: painDetailsModel!.typeOfPain
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             Divider(thickness: 1, color: Colors.black),
                      //
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 10.0,
                      //               ),
                      //               child: CustomText(
                      //                 text: 'Past Medical History',
                      //                 fontSize: 14,
                      //                 color: AppColors.primaryColor,
                      //               ),
                      //             ),
                      //
                      //             pastMedicalHistoryModel != null
                      //                 ? _text(
                      //                     firstText: 'Surgical History',
                      //                     secondText: pastMedicalHistoryModel!
                      //                         .displaySurgicalHistory
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             pastMedicalHistoryModel != null
                      //                 ? _text(
                      //                     firstText: 'Medical History',
                      //                     secondText: pastMedicalHistoryModel!
                      //                         .medicalHistory
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             pastMedicalHistoryModel != null
                      //                 ? _text(
                      //                     firstText: 'Medical History Details',
                      //                     secondText: pastMedicalHistoryModel!
                      //                         .medicalHistoryDetails
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             pastMedicalHistoryModel != null
                      //                 ? _text(
                      //                     firstText: 'Previous Treatments',
                      //                     secondText: pastMedicalHistoryModel!
                      //                         .previousTreatments
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             pastMedicalHistoryModel != null
                      //                 ? _text(
                      //                     firstText: 'Treatment Responses',
                      //                     secondText: pastMedicalHistoryModel!
                      //                         .treatmentResponses
                      //                         .values
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //
                      //             painLocationModel != null
                      //                 ? _text(
                      //                     firstText: 'Pain Location',
                      //                     secondText: painLocationModel!
                      //                         .painLocation
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             previousInvestigationsModel != null
                      //                 ? _text(
                      //                     firstText: 'Investigations Done',
                      //                     secondText: previousInvestigationsModel!
                      //                         .investigationsDone
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             redFlagsModel != null
                      //                 ? _text(
                      //                     firstText: 'Red Flags',
                      //                     buttonText: redFlagsModel!.flags
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             radiatingPainModel != null
                      //                 ? _text(
                      //                     firstText: 'Radiating Status',
                      //                     buttonText: radiatingPainModel!
                      //                         .displayRadiatingStatus
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             radiatingPainModel != null
                      //                 ? _text(
                      //                     firstText: 'Radiating Side',
                      //                     buttonText: radiatingPainModel!
                      //                         .displayRadiationSide
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             radiatingPainModel != null
                      //                 ? _text(
                      //                     firstText: 'Radiating Path',
                      //                     buttonText: radiatingPainModel!
                      //                         .radiationPath
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             functionalLimitationsModel != null
                      //                 ? _text(
                      //                     firstText: 'Limited Activities',
                      //                     buttonText: functionalLimitationsModel!
                      //                         .limitedActivities
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             onsetAndCauseModel != null
                      //                 ? _text(
                      //                     firstText: 'How Did It Start',
                      //                     buttonText: onsetAndCauseModel!
                      //                         .displayHowDidItStart
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             onsetAndCauseModel != null
                      //                 ? _text(
                      //                     firstText: 'Possible Cause',
                      //                     buttonText: onsetAndCauseModel!
                      //                         .possibleCause
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             previousInvestigationsModel != null
                      //                 ? _text(
                      //                     firstText: 'Investigations Done',
                      //                     buttonText: previousInvestigationsModel!
                      //                         .investigationsDone
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             gaitAnalysisModel != null
                      //                 ? _text(
                      //                     firstText: 'Display Analysis',
                      //                     buttonText: gaitAnalysisModel!
                      //                         .displayAnalysis
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //             relievingFactorsModel != null
                      //                 ? _text(
                      //                     firstText: 'Factors',
                      //                     buttonText: relievingFactorsModel!
                      //                         .factors
                      //                         .toString(),
                      //                   )
                      //                 : SizedBox(),
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   }),
                      // ],
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
                          onTap: () => context.read<HistoryTrackerBloc>().add(
                            HistoryTrackerEvent(visitId: widget.visitId),
                          ),
                          child: Icon(Icons.refresh),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}

Widget _text({
  required String firstText,
  String? secondText,
  String? buttonText,
}) {
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
