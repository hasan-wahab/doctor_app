import 'dart:convert';

import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboad_states.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_event.dart';
import 'package:doctor_app/screens/dashboard_screen/dashboard_chart.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../data/api_service/api_service.dart';
import '../../data/local_storage/local_curd_base/local_curd_impl.dart';
import '../../data/local_storage/local_storage.dart';
import '../../data/models/current_patient_model.dart';
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
  int totalSession = 8;
  int usedSession = 6;

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
    Icons.warning_amber_outlined,
  ];

  List<String> cardText = [
    'Visits',
    'Active packages',
    'Assessments',
    'Invoice',
    'Sessions',
    'Assistant Manager',
  ];
  List<String> screenNameList = [
    AppRoutes.visitsDetailScreen,
    AppRoutes.packagesDetailScreen,
    AppRoutes.assessmentScreen,
    AppRoutes.invoiceDetailScreen,
    AppRoutes.sessionsDetailScreen,
    AppRoutes.assistantManagerScreen,
  ];
  LoginModel1? profileData;
  CurrentPatientModel? currentPatientData;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardStates>(
      listener: (context, state) {
        if (state is DashboardLoadingState) {
          isLoading = true;
        } else {
          isLoading = false;
        }

        if (state is DashboardMessageState) {
          AppMsg.showErrorMsg(context, msg: state.massage);
        }

        if (state is DashboardLoadedState) {
          currentPatientData = state.patientData;
          profileData = state.profileData;
          print(currentPatientData!.therapySessions.first.endTime);
          print(profileData!.patientData!.patientInfo!.email.toString());
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
                                      child:
                                          profileData!.user!.profilePicture !=
                                              null
                                          ? Image.network(
                                              fit: BoxFit.cover,
                                              'https://alitherapy.neonweb.tech/storage/${currentPatientData!.patient!.image.toString()}',

                                              headers: {
                                                "Authorization":
                                                    "Bearer ${profileData!.accessToken.toString()}",
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return profileData!.user !=
                                                            null
                                                        ? Image.network(
                                                            profileData!
                                                                .user!
                                                                .profilePicture
                                                                .toString(),
                                                          )
                                                        : Container();
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
                                        text:
                                            'Hi, ${currentPatientData!.patient!.user!.name.toString()}',
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
                                          CustomText(
                                            text: isObscureBalanceText != true
                                                ? 'PKR ${currentPatientData!.patient!.walletBalance}'
                                                : '* * * * * *',
                                            fontSize: 13,
                                            color: AppColors.textWhiteColor,
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
                                        CustomText(
                                          text:
                                              'Total:  ${int.parse(currentPatientData!.stats!.totalAmount.toString())}',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textWhiteColor,
                                        ),

                                        CustomText(
                                          text:
                                              'Paid: ${double.parse(currentPatientData!.stats!.totalSpend)}',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textWhiteColor,
                                        ),
                                        CustomText(
                                          text:
                                              'Remaining: ${currentPatientData!.stats!.totalAmount - double.parse(currentPatientData!.stats!.totalSpend)}',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textWhiteColor,
                                        ),
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
                                          value: getTotalPaymentProgress(),
                                          strokeWidth: 12,
                                          backgroundColor: Colors.grey.shade300,
                                          valueColor: AlwaysStoppedAnimation(
                                            AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          CustomText(
                                            text:
                                                "${(getTotalPaymentProgress() * 100).toStringAsFixed(0)}%",
                                            fontWeight: FontWeight.bold,
                                          ),
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
                              ...List.generate((6), (index) {
                                List cardSecondText = [
                                  currentPatientData!.patient!.visits.length
                                      .toString(),
                                  currentPatientData!.patient!.packages.length
                                      .toString(),
                                  '',
                                  currentPatientData!.recentInvoices.length
                                      .toString(),
                                  currentPatientData!.therapySessions.length
                                      .toString(),
                                  '',
                                ];
                                final screenWidth =
                                    MediaQuery.sizeOf(context).width / 2.2;
                                return InkWell(
                                  onTap: () async {
                                    Navigator.pushNamed(
                                      context,
                                      screenNameList[index],
                                      arguments: <String, CurrentPatientModel>{
                                        "data": currentPatientData!,
                                      },
                                    );
                                  },
                                  child: Card(
                                    color: Colors.transparent,
                                    margin: EdgeInsets.zero,
                                    child: Container(
                                      height: 58.h,
                                      width: screenWidth,

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
                        currentPatientData!.patient!.packages.isNotEmpty
                            ? CustomText(text: 'Session Progress')
                            : Container(),
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
                                            ? 'No data'
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
                                                '${currentPatientData!.patient!.packages.isNotEmpty ? currentPatientData!.patient!.packages[index].pivot!.sessionsTotal : 0}/${currentPatientData!.patient!.packages.isNotEmpty ? currentPatientData!.patient!.packages[index].pivot!.sessionsUsed : 0}',
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
                                            text:
                                                currentPatientData!
                                                    .patient!
                                                    .packages
                                                    .isNotEmpty
                                                ? DateAndTimeFormater.dateFormat(
                                                    currentPatientData!
                                                        .therapySessions[index]
                                                        .nextSessionDate
                                                        .toString(),
                                                  )
                                                : 'No data',
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
                  ),
                )
              : Center(child: Text('No Data Found')),
        );
      },
    );
  }

  // getCurrentUserDataFromApi() async {
  //   if (!mounted) return;
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   final token = await LocalStorage.getUserToken('token');
  //   final currentUserData = await LocalStorage.getProfileData(token!);
  //
  //   final jsonData = jsonDecode(currentUserData!);
  //
  //   profileData = LoginModel1.fromJson(jsonData);
  //   if (!mounted) return;
  //
  //   currentPatientData = await ApiServices.getPatientData(
  //     patientId: profileData!.patientData!.patientInfo!.id.toString(),
  //     currentUserToken: profileData!.accessToken.toString(),
  //     context: context,
  //   );
  //   if (!mounted) return;
  //
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

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

  double getTotalPaymentProgress() {
    final total = currentPatientData!.stats!.totalAmount;
    final paid = currentPatientData!.stats!.totalSpend;

    if (total == 0) return 0.0;

    final progress = double.parse(paid.toString()) / total!;

    if (progress.isNaN || progress.isInfinite) return 0.0;

    return progress.clamp(0.0, 1.0);
  }

  double getSessionProgress(int index) {
    final total =
        currentPatientData!.patient!.packages[index].pivot!.sessionsTotal;
    final used =
        currentPatientData!.patient!.packages[index].pivot!.sessionsUsed;

    if (total == 0) return 0.0;

    final progress = used! / total!;

    if (progress.isNaN || progress.isInfinite) return 0.0;

    return progress.clamp(0.0, 1.0);
  }
}
