import 'dart:async';

import 'package:doctor_app/core/extentions/context_extentions.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboad_states.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_event.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:doctor_app/widgets/new-widget/balance%20card.dart';
import 'package:doctor_app/widgets/new-widget/quick_overview_card.dart';
import 'package:doctor_app/widgets/new-widget/session_progress_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/app_styles/app_text_styles.dart';
import '../../core/extentions/internect_connectivity.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/app_pull_refresh.dart';
import '../../widgets/new-widget/dashboard_appbar.dart';
import '../../widgets/show_msg.dart';
import 'dashboard_shimmer.dart';

class DashbordScreen extends StatefulWidget {
  const DashbordScreen({super.key});

  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  late Timer _timer;

  bool isLoading = false;
  bool isRefreshing = false;
  bool hasInternet = false;

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardStates>(
      listener: (context, state) {
        print(state);
        if (state is DashboardLoadingState) {
          if (currentPatientData == null) {
            isLoading = true;
          } else {
            isRefreshing = true;
          }
        } else {
          isLoading = false;
          isRefreshing = false;
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
        final firstLoad = isLoading && currentPatientData == null;
        final appBarLoading = isLoading || isRefreshing;

        return Scaffold(
          backgroundColor: AppColors.screenBgColor,
          appBar: DashboardAppbar(
            onAvatarTap: () => context.push(AppRoutes.myProfileScreen),
            imageUrl: profileImage,
            date: DateTime.now(),
            userName: patientName ?? '',
            isLoading: appBarLoading,
          ),
          body: firstLoad
              ? const DashboardShimmer()
              : currentPatientData != null
              ? Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: AppSizes.contentMaxWidth(context),
                    ),
                    child: AppPullRefresh(
                      enabled: !appBarLoading,
                      onRefresh: _onRefresh,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: AppSizes.pageInsets,
                        children: [
                          CustomText(
                              text: 'Payment Overview',
                              style: AppTextStyles.name,
                            ),
                            SizedBox(height: AppSizes.spaceMd),
                            BalanceCard(
                              currentBalance: walletBalance.toString(),
                              discount: totalDiscount.toString(),
                              total: totalAmount.toString(),
                              insurance: totalInsuranceDiscount.toString(),
                              paid: totalSpend.toString(),
                              remaining: remaining.toString(),
                            ),
                            SizedBox(height: AppSizes.spaceXxl),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text: 'Quick Overview',
                                    style: AppTextStyles.name,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSizes.gapMd,
                                    vertical: AppSizes.spaceXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.radiusLg,
                                    ),
                                  ),
                                  child: CustomText(
                                    text: '5 actions',
                                    style: AppTextStyles.chipPrimary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppSizes.spaceMd),
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
                              assessments: patientModel!.visits
                                  .where((v) => v.consultantAssessment != null)
                                  .length
                                  .toString(),
                              invoice: currentPatientData!.recentInvoices.length
                                  .toString(),
                              sessions: currentPatientData!
                                  .therapySessions
                                  .length
                                  .toString(),
                            ),
                            SizedBox(height: AppSizes.spaceXxl),
                            patientModel!.packages.isNotEmpty
                                ? CustomText(
                                    text: 'Session Progress',
                                    style: AppTextStyles.name,
                                  )
                                : const SizedBox.shrink(),
                            if (patientModel!.packages.isNotEmpty)
                              SizedBox(height: AppSizes.spaceMd),
                            currentPatientData!.therapySessions.isEmpty
                                ? const SizedBox.shrink()
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
                                        final totalSessions = patientModel!
                                            .packages[index]
                                            .sessions!;
                                        final therapySessions =
                                            currentPatientData!.therapySessions;
                                        final hasTherapyAtIndex =
                                            index < therapySessions.length;
                                        final nextSessionDisplay =
                                            hasTherapyAtIndex
                                            ? therapySessions[index]
                                                .displayNextSessionDate
                                            : 'No data';

                                        return SessionProgressCard(
                                          title: packageName,
                                          progressLabel: 'Progress',
                                          completedSessions: completedSessions,
                                          nextSessionLabel:
                                              totalSessions == completedSessions
                                              ? 'Completed'
                                              : !hasTherapyAtIndex ||
                                                    nextSessionDisplay ==
                                                        'No data'
                                              ? ''
                                              : 'Next Session',
                                          nextSessionDate:
                                              totalSessions == completedSessions
                                              ? ''
                                              : !hasTherapyAtIndex
                                              ? ''
                                              : DateAndTimeFormater.dateFormat(
                                                  therapySessions[index]
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
                    ),
                  )
              : const DashboardShimmer(),
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    final bloc = context.read<DashboardBloc>();
    final done = bloc.stream.firstWhere(
      (state) =>
          state is DashboardLoadedState || state is DashboardMessageState,
    );
    bloc.add(DashboardRefreshDataEvent());
    await done;
  }

  void internetController() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (Timer t) async {
      hasInternet = await InternetUtils.isInternetAvailable();
      if (!mounted) return;
      setState(() {});
    });
  }
}
