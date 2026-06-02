import 'dart:convert';

import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api_impl.dart';
import 'package:doctor_app/data/models/all_visits_model.dart';
import 'package:doctor_app/repos/all_consultant_assessment_repo/all_consultant_assessmant_repo.dart';
import 'package:doctor_app/repos/all_packages_repo/all_packages_repo.dart';
import 'package:doctor_app/repos/all_therapy_session_repo/all_therapy_session_repo.dart';
import 'package:doctor_app/repos/all_visits_repo/all_visits_local_repo.dart';
import 'package:doctor_app/repos/all_visits_repo/all_visits_repo.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/auth_screen/bloc/login_bloc.dart';
import 'package:doctor_app/screens/auth_screen/bloc/login_events.dart';
import 'package:doctor_app/screens/auth_screen/bloc/login_states.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboad_states.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_event.dart';
import 'package:doctor_app/screens/dashboard_screen/dashboard_chart.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:doctor_app/widgets/feed_back_dilog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../core/functions.dart';
import '../../data/api_service/api_service.dart';
import '../../data/local_storage/local_curd_base/local_curd_impl.dart';
import '../../data/local_storage/local_storage.dart';
import '../../data/models/current_patient_model.dart';
import '../../repos/all_consultant_assessment_repo/all_consultant_assessmant_local_repo.dart';
import '../../widgets/app_button.dart';
import '../../widgets/show_msg.dart';

class DashbordScreen extends StatefulWidget {
  const DashbordScreen({super.key});

  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  bool isLoading = false;
  bool isObscureBalanceText = true;
  String totalSession = '1';
  String usedSession = '0';

  int totalPayment = 10;
  int paidPayment = 5;
  late int remainingPayments;
  @override
  void initState() {
    context.read<DashboardBloc>().add(DashboardLoadDataEvent());
    super.initState();
  }

  final List<IconData> icons = [
    Icons.remove_red_eye,
    Icons.payment,
    Icons.warning_amber_outlined,
    Icons.remove_red_eye,
    Icons.payment,
  ];

  List<String> cardText = [
    'Visits',
    'Active packages',
    'Assessments',
    'Invoice',
    'Sessions',
  ];
  List<String> screenNameList = [
    AppRoutes.visitsDetailScreen,
    AppRoutes.packagesDetailScreen,
    AppRoutes.assessmentScreen,
    AppRoutes.invoiceDetailScreen,
    AppRoutes.sessionsDetailScreen,
  ];
  LoginModel1? profileData;
  CurrentPatientModel? currentPatientData;

  String? profileImage, patientName, walletBalance;
  double? totalAmount, totalSpend, remaining;
  PatientModel? patientModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardStates>(
      listener: (context, state) {
        print(state);
        if (state is DashboardLoadingState) {
          isLoading = true;
        } else {
          isLoading = false;
        }

        if (state is DashboardMessageState) {
          AppMsg.showSnackBar(context, message: state.massage);
        }

        if (state is DashboardLoadedState) {
          currentPatientData = state.patientData;
          profileData = state.profileData;
          profileImage = state.patientData.patient!.displayImageUrl;
          patientName = state.patientData.patient!.displayName;
          walletBalance = state.patientData.patient!.displayWalletBalance;
          totalAmount = state.patientData.stats!.totalAmount;
          totalSpend = state.patientData.stats!.totalSpend;
          patientModel = state.patientData.patient;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          body: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : currentPatientData != null
              ? SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<DashboardBloc>().add(
                        DashboardRefreshDataEvent(),
                      );
                      return;
                    },
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10,
                      ),
                      children: [
                        /// AppBar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.myProfileScreen,
                                    );
                                  },
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipOval(
                                      child: profileImage != null
                                          ? Image.network(
                                              fit: BoxFit.cover,
                                              '$profileImage',
                                              headers: {
                                                "Authorization":
                                                    "Bearer ${profileData!.accessToken.toString()}",
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return CircleAvatar();
                                                  },
                                            )
                                          : CircleAvatar(),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200.w,
                                      child: CustomText(
                                        text: patientName != null
                                            ? 'Hi, $patientName'
                                            : '',
                                        fontSize: 18,
                                      ),
                                    ),
                                    CustomText(
                                      text:
                                          '0${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}',
                                      fontSize: 12,
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.searchScreen,
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.secondaryColor,
                                child: Icon(
                                  CupertinoIcons.search,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),

                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.secondaryColor,

                                  child: Icon(
                                    CupertinoIcons.bell,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Container(
                                  height: 10.h,
                                  width: 10.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 24.67.h),

                        /// Balance Card
                        Card(
                          color: AppColors.secondaryColor,
                          margin: EdgeInsets.zero,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            // height: 120.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryColor,
                                  Colors.greenAccent.shade200,
                                  AppColors.secondaryColor,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.whiteIconColor,
                              // border: Border.fromBorderSide(
                              //   BorderSide(color: AppColors.primaryColor),
                              // ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    spacing: 10.h,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'Balance',
                                        fontSize: 16,
                                        color: AppColors.textWhiteColor,
                                      ),

                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 10,
                                        children: [
                                          walletBalance != null
                                              ? CustomText(
                                                  text:
                                                      isObscureBalanceText !=
                                                          true
                                                      ? 'PKR $walletBalance'
                                                      : '* * * * * *',
                                                  fontSize: 13,
                                                  color:
                                                      AppColors.textWhiteColor,
                                                )
                                              : CustomText(
                                                  text: '0.0',
                                                  fontSize: 13,
                                                  color:
                                                      AppColors.textWhiteColor,
                                                ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isObscureBalanceText =
                                                    !isObscureBalanceText;
                                              });
                                            },
                                            child: isObscureBalanceText
                                                ? Icon(
                                                    Icons.visibility_off,
                                                    size: 18.r,
                                                    color: AppColors
                                                        .whiteIconColor,
                                                  )
                                                : Icon(
                                                    Icons.visibility,
                                                    size: 18.r,
                                                    color: AppColors
                                                        .whiteIconColor,
                                                  ),
                                          ),
                                        ],
                                      ),
                                      AppButton(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        text: 'Recharge wallet',
                                        width: 110,
                                        isColor: false,
                                        height: 34,
                                        textSize: 11,
                                        onTap: () async {},
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 100.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        totalAmount != null
                                            ? CustomText(
                                                text: 'Total:  $totalAmount',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textWhiteColor,
                                              )
                                            : SizedBox(),

                                        totalSpend != null
                                            ? CustomText(
                                                text: 'Paid: $totalSpend',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textWhiteColor,
                                              )
                                            : SizedBox(),
                                        remaining != null
                                            ? CustomText(
                                                text:
                                                    'Remaining: ${totalAmount! - totalSpend!}',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textWhiteColor,
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: 80.h,
                                        width: 80.w,
                                        child: CircularProgressIndicator(
                                          value:
                                              totalAmount != null &&
                                                  totalSpend != null
                                              ? getTotalPaymentProgress(
                                                  total: totalAmount,
                                                  paid: totalSpend,
                                                )
                                              : 0.0,
                                          strokeWidth: 12,
                                          backgroundColor: Colors.grey.shade300,
                                          valueColor: AlwaysStoppedAnimation(
                                            AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          totalAmount != null
                                              ? CustomText(
                                                  text:
                                                      "${(getTotalPaymentProgress(total: totalAmount, paid: totalSpend) * 100).toStringAsFixed(0)}%",
                                                  fontWeight: FontWeight.bold,
                                                )
                                              : SizedBox(),
                                          const SizedBox(height: 4),
                                          CustomText(
                                            text: "Completed",
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 10.h),

                        /// OverView
                        CustomText(text: 'Quick Overview', fontSize: 14),
                        SizedBox(height: 10.h),

                        SizedBox(
                          width: MediaQuery.sizeOf(context).width - 15,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 15.h,
                            direction: Axis.horizontal,
                            verticalDirection: VerticalDirection.down,
                            children: [
                              ...List.generate((screenNameList.length), (
                                index,
                              ) {
                                List cardSecondText = [
                                  patientModel!.visits.length.toString(),
                                  patientModel!.packages.length.toString(),
                                  '',
                                  currentPatientData!.recentInvoices.length
                                      .toString(),
                                  currentPatientData!.therapySessions.length
                                      .toString(),
                                ];
                                final screenWidth = MediaQuery.sizeOf(
                                  context,
                                ).width;
                                return InkWell(
                                  onTap: () async {
                                    Navigator.pushNamed(
                                      context,
                                      screenNameList[index],
                                    );
                                  },
                                  child: Card(
                                    color: Colors.transparent,
                                    margin: EdgeInsets.zero,
                                    child: Container(
                                      height: 58.h,
                                      width: index == 4
                                          ? screenWidth
                                          : screenWidth / 2.2,

                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryColor,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                cardSecondText[index] != ''
                                                ? MainAxisAlignment.spaceBetween
                                                : MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 100.w,
                                                child: CustomText(
                                                  text: cardText[index],
                                                  fontSize: 12,
                                                  maxLines: index == 5 ? 2 : 1,
                                                ),
                                              ),
                                              cardSecondText[index] != ''
                                                  ? SizedBox(
                                                      width: 100.w,
                                                      child: CustomText(
                                                        text:
                                                            cardSecondText[index],
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          Icon(icons[index]),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),

                        SizedBox(height: 10.h),

                        /// Session Progress
                        patientModel!.packages.isNotEmpty
                            ? CustomText(text: 'Session Progress')
                            : Container(),
                        SizedBox(height: 10.h),
                        ...List.generate(patientModel!.packages.length, (
                          index,
                        ) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: patientModel!.packages.isEmpty
                                          ? 'No data'
                                          : patientModel!.packages[index].name
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
                                              '${patientModel!.packages[index].pivot!.displaySessionsUsed}/${patientModel!.packages[index].pivot!.sessionsTotal}',
                                          fontSize: 10,
                                        ),
                                      ],
                                    ),

                                    LinearProgressIndicator(
                                      value: patientModel!.packages.isEmpty
                                          ? 1.0
                                          : getSessionProgress(
                                              totalSession: patientModel!
                                                  .packages[index]
                                                  .pivot!
                                                  .displaySessionsTotal,
                                              usedSession: patientModel!
                                                  .packages[index]
                                                  .pivot!
                                                  .displaySessionsUsed,
                                            ),
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
                                        currentPatientData!
                                                .therapySessions
                                                .isNotEmpty
                                            ? CustomText(
                                                text: DateAndTimeFormater.dateFormat(
                                                  // currentPatientData!
                                                  currentPatientData!
                                                      .therapySessions[index]
                                                      .displayNextSessionDate
                                                      .toString(),
                                                ),

                                                fontSize: 12,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        );
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

  double getTotalPaymentProgress({required total, required paid}) {
    if (total == 0) return 0.0;
    if (paid == 0) return 0.0;
    final progress = paid / total!;

    if (progress.isNaN || progress.isInfinite) return 0.0;

    return progress.clamp(0.0, 1.0);
  }
}
