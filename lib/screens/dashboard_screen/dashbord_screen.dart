import 'dart:async';
import 'dart:convert';

import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/core/extentions/context_extentions.dart';

import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboad_states.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_event.dart';
import 'package:doctor_app/screens/dashboard_screen/dashboard_entity/dashboard_entity.dart';

import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:doctor_app/widgets/new-widget/balance%20card.dart';
import 'package:doctor_app/widgets/new-widget/quick_overview_card.dart';
import 'package:doctor_app/widgets/new-widget/session_progress_card.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../core/extentions/internect_connectivity.dart';
import '../../core/functions.dart';

import '../../data/models/current_patient_model.dart';
import '../../widgets/app_button.dart';
import '../../widgets/new-widget/dashboard_appbar.dart';
import '../../widgets/show_msg.dart';

class DashbordScreen extends StatefulWidget {
  const DashbordScreen({super.key});

  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  late Timer _timer;

  bool isLoading = false;
  bool hasInternet = false;
  bool isObscureBalanceText = true;
  int totalSession = 0;
  int usedSession = 0;

  int totalPayment = 10;
  int paidPayment = 5;
  late int remainingPayments;
  @override
  void initState() {
    context.read<DashboardBloc>().add(DashboardLoadDataEvent());
    internetController();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  LoginModel1? profileData;
  CurrentPatientModel? currentPatientData;

  String? profileImage, patientName, walletBalance;
  double? totalAmount, totalSpend, remaining;
  double? totalInsuranceDiscount, totalDiscount;
  PatientModel? patientModel;

  ///
  BalanceCardEntity? balanceCardEntity;
  DashboardHeaderEntity? dashboardHeaderEntity;
  List<SessionProgressEntity>? sessionProgressEntity;
  QuickOverviewEntity? quickOverviewEntity;

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
          remaining = state.patientData.stats!.remaining;
          totalDiscount = state.patientData.stats!.totalDiscount;
          totalInsuranceDiscount =
              state.patientData.stats!.totalInsuranceDiscount;
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
                        DashboardAppbar(
                          onAvatarTap: () =>
                              context.push(AppRoutes.myProfileScreen),
                          imageUrl: profileImage,
                          date: DateTime.now(),
                          userName: patientName.toString(),
                        ),
                        SizedBox(height: 10.h),
                        CustomText(text: 'Payment Overview', fontSize: 14),
                        SizedBox(height: 10.h),
                        BalanceCard(
                          currentBalance: walletBalance.toString(),
                          discount: totalDiscount.toString(),
                          total: totalAmount.toString(),
                          insurance: totalInsuranceDiscount.toString(),
                          paid: totalSpend.toString(),
                          remaining: remaining.toString(),
                        ),

                        SizedBox(height: 10.h),

                        /// OverView
                        CustomText(text: 'Quick Overview', fontSize: 14),
                        SizedBox(height: 10.h),

                        QuickOverview(
                          onVisitsTap: () {
                            context.push(AppRoutes.visitsDetailScreen);
                          },
                          onActivePackagesTap: () {
                            context.push(AppRoutes.packagesDetailScreen);
                          },
                          onAssessmentsTap: () {
                            context.push(AppRoutes.assessmentScreen);
                          },
                          onInvoiceTap: () {
                            context.push(AppRoutes.invoiceDetailScreen);
                          },
                          onSessionsTap: () {
                            context.push(AppRoutes.sessionsDetailScreen);
                          },
                          visits: patientModel!.visits.length.toString(),
                          activePackages: patientModel!.packages.length
                              .toString(),
                          invoice: currentPatientData!.recentInvoices.length
                              .toString(),
                          sessions: currentPatientData!.therapySessions.length
                              .toString(),
                        ),
                        SizedBox(height: 10.h),

                        /// Session Progress
                        patientModel!.packages.isNotEmpty
                            ? CustomText(text: 'Session Progress')
                            : Container(),
                        SizedBox(height: 10.h),
                        currentPatientData!.therapySessions.isEmpty
                            ? Container()
                            : Column(
                                children: List.generate(
                                  patientModel!.packages.length,
                                  (index) {
                                    final packageName = patientModel!
                                        .packages[index]
                                        .displayName
                                        .toSentenceCase;
                                    final completedSessions = patientModel!
                                        .packages[index]
                                        .pivot!
                                        .sessionsUsed!;
                                    final totalSessions =
                                        patientModel!.packages[index].sessions!;

                                    return SessionProgressCard(
                                      title: packageName,
                                      progressLabel: 'Progress',
                                      completedSessions: completedSessions,
                                      nextSessionLabel:
                                          totalSessions == completedSessions
                                          ? 'Completed'
                                          : currentPatientData
                                                    ?.therapySessions[index]
                                                    .displayNextSessionDate ==
                                                'No data'
                                          ? ''
                                          : 'Next Session',
                                      nextSessionDate:
                                          totalSessions == completedSessions
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
                              ),
                      ],
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  void internetController() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (Timer t) async {
      hasInternet = await InternetUtils.isInternetAvailable();
      if (!mounted) return; // ✅ IMPORTANT
      setState(() {});
    });
  }
}
