import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
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
                            return Container(
                              margin: EdgeInsets.only(bottom: 10.h),

                              height: 110.h,
                              width: 360.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Card(
                                color: AppColors.secondaryColor,
                                margin: EdgeInsets.zero,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.h,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text:
                                            currentPatientData!
                                                .patient!
                                                .packages
                                                .isEmpty
                                            ? 'No Data'
                                            : currentPatientData!
                                                  .patient!
                                                  .packages[index]
                                                  .name
                                                  .toString(),
                                        fontSize: 12,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: 'Sessions Progress',
                                            fontSize: 12,
                                            color: AppColors.secondaryTextColor,
                                          ),
                                          CustomText(
                                            text:
                                                '${currentPatientData!.patient!.packages.isNotEmpty ? currentPatientData!.patient!.packages[index].pivot!.displaySessionsUsed : 0}/${currentPatientData!.patient!.packages.isNotEmpty ? currentPatientData!.patient!.packages[index].pivot!.displaySessionsTotal : 0}',
                                            fontSize: 10,
                                          ),
                                        ],
                                      ),

                                      LinearProgressIndicator(
                                        value:
                                            currentPatientData!
                                                .patient!
                                                .packages
                                                .isEmpty
                                            ? 1.0
                                            : getSessionProgress(index),
                                        valueColor: AlwaysStoppedAnimation(
                                          AppColors.primaryColor,
                                        ),
                                      ),

                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: 'Next Session Date',
                                            fontSize: 15,
                                          ),
                                          CustomText(
                                            text: currentPatientData!
                                                .therapySessions[index]
                                                .displayNextSessionDate,
                                            fontSize: 12,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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

  double getSessionProgress(int index) {
    final total = currentPatientData!
        .patient!
        .packages[index]
        .pivot!
        .displaySessionsUsed
        .toString();
    final used = currentPatientData!
        .patient!
        .packages[index]
        .pivot!
        .displaySessionsTotal
        .toString();

    if (total == 0) return 0.0;

    final progress = double.parse(used) / double.parse(total);

    if (progress.isNaN || progress.isInfinite) return 0.0;

    return progress.clamp(0.0, 1.0);
  }
}
