import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/row_text.dart';
import '../../widgets/show_msg.dart';
import '../profile_screens/bloc/profile_state.dart';

class AssistantManagerScreen extends StatefulWidget {
  const AssistantManagerScreen({super.key});

  @override
  State<AssistantManagerScreen> createState() => _AssistantManagerScreenState();
}

class _AssistantManagerScreenState extends State<AssistantManagerScreen> {
  CurrentPatientModel? currentPatientData;
  bool isLoading = false;
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
        } else if (state is ProfileMessageState) {
          isLoading = false;

          AppMsg.showErrorMsg(context, msg: state.message.toString());
        }
      },
      builder: (context, state) {
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
                  title: Text('Assistant manager'),
                  automaticallyImplyLeading: false,
                ),
                backgroundColor: AppColors.bgColor,
                body:
                    currentPatientData != null &&
                        currentPatientData!.patient != null &&
                        currentPatientData!.patient!.visits.isNotEmpty
                    ? ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        children: [
                          CustomText(
                            text: 'Assistant Manager Assessment',
                            fontSize: 20,
                            color: AppColors.primaryColor,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(
                              currentPatientData!.patient!.visits.isNotEmpty
                                  ? currentPatientData!.patient!.visits.length
                                  : 1,
                              (index) {
                                if (currentPatientData!
                                    .patient!
                                    .visits
                                    .isNotEmpty) {
                                  return Card(
                                    margin: EdgeInsets.only(top: 10.h),
                                    color: AppColors.secondaryColor,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15.w,
                                        vertical: 20.h,
                                      ),
                                      // height: 420.h,
                                      width: 360.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),

                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RowText(
                                            firstText: 'Visit Date #',
                                            secondText:
                                                DateAndTimeFormater.dateFormat(
                                                  currentPatientData!
                                                      .patient!
                                                      .displayCreatedAt,
                                                ),
                                          ),
                                          RowText(
                                            firstText: 'AM Name',
                                            secondText: currentPatientData!
                                                .patient!
                                                .visits[index]
                                                .assistantManager!
                                                .displayName,
                                          ),
                                          RowText(
                                            firstText: 'Consultant',
                                            secondText:
                                                currentPatientData!
                                                        .patient!
                                                        .visits[index]
                                                        .consultant !=
                                                    null
                                                ? currentPatientData!
                                                      .patient!
                                                      .visits[index]
                                                      .consultant!
                                                      .displayName
                                                : '',
                                          ),

                                          RowText(
                                            firstText: 'Occupation',
                                            secondText: currentPatientData!
                                                .patient!
                                                .displayOccupation,
                                          ),
                                          RowText(
                                            firstText: 'Chief Complaint',
                                            secondText:
                                                currentPatientData!
                                                        .patient!
                                                        .visits[index]
                                                        .historyTaking !=
                                                    null
                                                ? currentPatientData!
                                                      .patient!
                                                      .visits[index]
                                                      .historyTaking!
                                                      .displayChiefComplaint
                                                : "",
                                          ),
                                          RowText(
                                            firstText: 'Complaint Onset',
                                            secondText:
                                                currentPatientData!
                                                        .patient!
                                                        .visits[index]
                                                        .historyTaking !=
                                                    null
                                                ? currentPatientData!
                                                      .patient!
                                                      .visits[index]
                                                      .historyTaking!
                                                      .displayComplaintOnset
                                                : '',
                                          ),
                                          RowText(
                                            firstText: 'Pain Severity',
                                            secondText:
                                                currentPatientData!
                                                        .patient!
                                                        .visits[index]
                                                        .historyTaking !=
                                                    null
                                                ? currentPatientData!
                                                      .patient!
                                                      .visits[index]
                                                      .historyTaking!
                                                      .displayPainSeverity
                                                : '',
                                          ),
                                          RowText(
                                            firstText: 'Pain Type',
                                            secondText:
                                                currentPatientData!
                                                        .patient!
                                                        .visits[index]
                                                        .historyTaking !=
                                                    null
                                                ? currentPatientData!
                                                      .patient!
                                                      .visits[index]
                                                      .historyTaking!
                                                      .displayPainType
                                                : '',
                                          ),

                                          RowText(
                                            firstText: 'Pain Location',
                                            secondText:
                                                currentPatientData!
                                                        .patient!
                                                        .visits[index]
                                                        .historyTaking !=
                                                    null
                                                ? currentPatientData!
                                                      .patient!
                                                      .visits[index]
                                                      .historyTaking!
                                                      .displayPainLocation
                                                : '',
                                          ),
                                          RowText(
                                            firstText: 'Pain Radiation',
                                            secondText:
                                                currentPatientData!
                                                        .patient!
                                                        .visits[index]
                                                        .historyTaking !=
                                                    null
                                                ? currentPatientData!
                                                      .patient!
                                                      .visits[index]
                                                      .historyTaking!
                                                      .displayPainRadiationSide
                                                : '',
                                          ),
                                          RowText(
                                            firstText: 'Aggravating Factors',
                                            secondText:
                                                currentPatientData!
                                                        .patient!
                                                        .visits[index]
                                                        .historyTaking !=
                                                    null
                                                ? currentPatientData!
                                                      .patient!
                                                      .visits[index]
                                                      .historyTaking!
                                                      .displayAggravatingFactors
                                                : '',
                                          ),
                                          RowText(
                                            firstText: 'Relieving Factors',
                                            secondText:
                                                currentPatientData!
                                                        .patient!
                                                        .visits[index]
                                                        .historyTaking !=
                                                    null
                                                ? currentPatientData!
                                                      .patient!
                                                      .visits[index]
                                                      .historyTaking!
                                                      .displayRelievingFactors
                                                : '',
                                          ),

                                          RowText(
                                            firstText: 'Consent',
                                            buttonText:
                                                currentPatientData!
                                                        .patient!
                                                        .visits[index]
                                                        .historyTaking !=
                                                    null
                                                ? currentPatientData!
                                                      .patient!
                                                      .visits[index]
                                                      .historyTaking!
                                                      .displayConsentGiven
                                                : '',
                                          ),

                                          RowText(
                                            firstText: 'Red Flags',
                                            secondText: currentPatientData!
                                                .patient!
                                                .visits[index]
                                                .displayStatus,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return Center(child: Container());
                              },
                            ),
                          ),
                        ],
                      )
                    : Center(child: CustomText(text: 'No data')),
              )
            : Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
