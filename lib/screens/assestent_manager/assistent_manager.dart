import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/custom_text.dart';
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
                body: ListView(
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

                    currentPatientData != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(
                              currentPatientData!.patient.visits.isNotEmpty
                                  ? currentPatientData!.patient.visits.length
                                  : 1,
                              (index) {
                                if (currentPatientData!
                                    .patient
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
                                          _text(
                                            firstText: 'Visit Date #',
                                            secondText:
                                                currentPatientData!
                                                    .patient
                                                    .createdAt
                                                    .toString()
                                                    .isEmpty
                                                ? 'no data'
                                                : DateAndTimeFormater.dateFormat(
                                                    currentPatientData!
                                                        .patient
                                                        .createdAt
                                                        .toString(),
                                                  ),
                                          ),
                                          _text(
                                            firstText: 'AM Name',
                                            secondText: currentPatientData!
                                                .patient
                                                .visits[index]
                                                .assistantManager
                                                .name
                                                .toString(),
                                          ),
                                          _text(
                                            firstText: 'Consultant',
                                            secondText: currentPatientData!
                                                .patient
                                                .visits[index]
                                                .consultant
                                                .name,
                                          ),

                                          _text(
                                            firstText: 'Occupation',
                                            secondText: currentPatientData!
                                                .patient
                                                .occupation,
                                          ),
                                          _text(
                                            firstText: 'Chief Complaint',
                                            secondText: currentPatientData!
                                                .patient
                                                .visits[index]
                                                .historyTaking['chief_complaint']
                                                .toString(),
                                          ),
                                          _text(
                                            firstText: 'Complaint Onset',
                                            secondText: currentPatientData!
                                                .patient
                                                .visits[index]
                                                .historyTaking['complaint_onset']
                                                .toString(),
                                          ),
                                          _text(
                                            firstText: 'Pain Severity',
                                            secondText: currentPatientData!
                                                .patient
                                                .visits[index]
                                                .historyTaking['pain_severity']
                                                .toString(),
                                          ),
                                          _text(
                                            firstText: 'Pain Type',
                                            secondText: currentPatientData!
                                                .patient
                                                .visits[index]
                                                .historyTaking['pain_type']
                                                .toString(),
                                          ),

                                          _text(
                                            firstText: 'Pain Location',
                                            secondText: currentPatientData!
                                                .patient
                                                .visits[index]
                                                .historyTaking['pain_location']
                                                .toString(),
                                          ),
                                          _text(
                                            firstText: 'Pain Radiation',
                                            secondText: currentPatientData!
                                                .patient
                                                .visits[index]
                                                .historyTaking['pain_radiation']
                                                .toString(),
                                          ),
                                          _text(
                                            firstText: 'Aggravating Factors',
                                            secondText: currentPatientData!
                                                .patient
                                                .visits[index]
                                                .historyTaking['aggravating_factors']
                                                .toString(),
                                          ),
                                          _text(
                                            firstText: 'Relieving Factors',
                                            secondText: currentPatientData!
                                                .patient
                                                .visits[index]
                                                .historyTaking['aggravating_factors']
                                                .toString(),
                                          ),
                                          _text(
                                            firstText: 'Functional Impact',
                                            secondText: currentPatientData!
                                                .patient
                                                .visits[index]
                                                .historyTaking['functional_impact']
                                                .toString(),
                                          ),

                                          _text(
                                            firstText: 'Consent',
                                            buttonText: currentPatientData!
                                                .patient
                                                .visits[index]
                                                .historyTaking['consent']
                                                .toString(),

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
                                                  text: currentPatientData!
                                                      .patient
                                                      .visits[index]
                                                      .status,
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
                        : Center(child: Text('No data')),
                  ],
                ),
              )
            : Scaffold(body: Center(child: CircularProgressIndicator()));
      },
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
                          text: buttonText ?? '',
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
