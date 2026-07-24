import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/widgets/new-widget/session_progress_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../core/extentions/context_extentions.dart';
import '../../core/functions.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/date_time_foemat.dart';
import '../../widgets/show_msg.dart';
import '../profile_screens/bloc/profile_event.dart';
import '../profile_screens/bloc/profile_state.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
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
        } else {
          isLoading = false;
        }
        if (state is ProfileMessageState) {
          AppMsg.showErrorMsg(context, msg: state.message.toString());
        }
        if (state is MyProfileState) {
          currentPatientData = state.currentPatientModel;
          //  profileData = state.profileData;
        }
      },
      builder: (context, state) {
        return isLoading == false && currentPatientData != null
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
                  title: Text('Packages'),
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
                      text: 'Treatment Packages',
                      fontSize: 20,
                      color: AppColors.primaryColor,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Session Progress
                        SizedBox(height: 10.h),
                        ...List.generate(
                          currentPatientData!.patient!.packages.isNotEmpty
                              ? currentPatientData!.patient!.packages.length
                              : 1,

                          (index) {
                            final packageName = currentPatientData!
                                .patient!
                                .packages[index]
                                .displayName
                                .toSentenceCase;
                            final completedSessions = currentPatientData!
                                .patient!
                                .packages[index]
                                .pivot!
                                .sessionsUsed!;
                            final totalSessions = currentPatientData!
                                .patient!
                                .packages[index]
                                .sessions!;
                            return SessionProgressCard(
                              title: packageName,
                              progressLabel: 'Progress',
                              completedSessions: completedSessions,
                              nextSessionLabel:
                                  totalSessions == completedSessions
                                  ? 'Completed'
                                  : currentPatientData!.therapySessions.isEmpty
                                  ? ''
                                  : currentPatientData
                                            ?.therapySessions[index]
                                            .displayNextSessionDate ==
                                        'No data'
                                  ? ''
                                  : 'Next Session',
                              nextSessionDate:
                                  totalSessions == completedSessions
                                  ? ''
                                  : currentPatientData!.therapySessions.isEmpty
                                  ? ''
                                  : DateAndTimeFormater.dateFormat(
                                      currentPatientData
                                          ?.therapySessions[index]
                                          .nextSessionDate,
                                    ),
                              totalSessions: totalSessions,
                            );
                          },
                        ),
                      ],
                    ),
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
  }) {
    return Column(
      spacing: 5.h,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: firstText),
        secondText != null
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
      ],
    );
  }
}
