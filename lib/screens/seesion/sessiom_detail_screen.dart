import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/show_msg.dart';

class SessionDetailScreen extends StatefulWidget {
  const SessionDetailScreen({super.key});

  @override
  State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends State<SessionDetailScreen> {
  CurrentPatientModel? currentPatientData;

  @override
  void initState() {
    context.read<ProfileBloc>().add(MyProfileEvent());
    super.initState();
  }

  bool isLoading = false;
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
                  title: Text('Sessions'),
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
                            text: 'Therapy Sessions',
                            fontSize: 20,
                            color: AppColors.primaryColor,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(
                              currentPatientData!.therapySessions.length,
                              (index) {
                                return Card(
                                  color: AppColors.secondaryColor,
                                  margin: EdgeInsets.only(top: 15.h),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                      vertical: 20.h,
                                    ),

                                    height: 178.h,
                                    width: 360.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      //  border: Border.all(color: AppColors.primaryColor, width: 2),
                                    ),

                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _text(
                                          firstText: 'Sessions#',
                                          secondText: currentPatientData!
                                              .therapySessions[index]
                                              .sessionNumber
                                              .toString(),
                                        ),
                                        _text(
                                          firstText: 'Next session date',
                                          secondText:
                                              DateAndTimeFormater.dateFormat(
                                                currentPatientData!
                                                    .therapySessions[index]
                                                    .nextSessionDate
                                                    .toString(),
                                              ),
                                        ),
                                        _text(
                                          firstText: 'Therapist',
                                          secondText: currentPatientData!
                                              .therapySessions[index]
                                              .therapist!
                                              .name
                                              .toString(),
                                        ),

                                        _text(
                                          firstText: 'Duration',
                                          secondText: currentPatientData!
                                              .therapySessions[index]
                                              .durationSeconds
                                              .toString(),
                                        ),
                                        _text(
                                          firstText: 'Notes',
                                          secondText:
                                              currentPatientData!
                                                  .therapySessions[index]
                                                  .notes
                                                  .isEmpty
                                              ? 'asd'
                                              : currentPatientData!
                                                    .therapySessions[index]
                                                    .notes,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : Center(child: CircularProgressIndicator()),
              )
            : Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _text({
    required String firstText,
    String? secondText,
    String? buttonText,
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
                        text: buttonText!,
                        color: AppColors.textWhiteColor,
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
