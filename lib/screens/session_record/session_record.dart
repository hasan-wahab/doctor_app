import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';
import 'package:doctor_app/screens/session_record/session_notes.dart';
import 'package:doctor_app/screens/session_record/session_record_shimmer.dart';
import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/app_styles/app_text_styles.dart';
import '../../core/extentions/context_extentions.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/app_pull_refresh.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/date_time_foemat.dart';
import '../../widgets/new-widget/session_progress_card.dart';
import '../../widgets/show_msg.dart';

class SessionRecord extends StatefulWidget {
  const SessionRecord({super.key});

  @override
  State<SessionRecord> createState() => _SessionRecordState();
}

class _SessionRecordState extends State<SessionRecord> {
  bool isLoading = false;
  bool isRefreshing = false;
  CurrentPatientModel? currentPatientData;
  LoginModel1? profileData;
  bool isVisitDetail = false;
  List<VisitModel> visits = [];

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(MyProfileEvent());
  }

  Future<void> _onRefresh() async {
    final bloc = context.read<ProfileBloc>();
    final done = bloc.stream.firstWhere(
      (state) => state is MyProfileState || state is ProfileMessageState,
    );
    bloc.add(MyProfileEvent());
    await done;
  }

  void _goHomeTab() {
    context.read<NaveBarBloc>().add(NaveBarIndexEvent(index: 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          if (currentPatientData == null) {
            isLoading = true;
          } else {
            isRefreshing = true;
          }
        } else if (state is MyProfileState) {
          isLoading = false;
          isRefreshing = false;
          profileData = state.profileData;
          currentPatientData = state.currentPatientModel;
          visits = state.visits!;
        } else {
          isLoading = false;
          isRefreshing = false;
          AppMsg.showErrorMsg(context, msg: state.toString());
        }
      },
      builder: (context, state) {
        final latestData = state is MyProfileState
            ? state.currentPatientModel
            : currentPatientData;
        final firstLoad = isLoading && latestData == null;
        final appBarLoading = isLoading || isRefreshing;

        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            _goHomeTab();
          },
          child: Scaffold(
            backgroundColor: AppColors.screenBgColor,
            appBar: AppAppBar(
              title: isVisitDetail == true ? 'Total visits' : 'Session Records',
              showBack: true,
              isLoading: appBarLoading,
              onBack: isVisitDetail == true
                  ? () {
                      setState(() {
                        isVisitDetail = false;
                      });
                    }
                  : _goHomeTab,
            ),
            body: firstLoad
                ? const SessionRecordShimmer()
                : Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: AppSizes.contentMaxWidth(context),
                      ),
                      child: AppPullRefresh(
                        enabled: !appBarLoading,
                        onRefresh: _onRefresh,
                        child: visits.isEmpty
                            ? ListView(
                                physics:
                                    const AlwaysScrollableScrollPhysics(),
                                children: [
                                  SizedBox(height: AppSizes.buttonHeight * 3),
                                  Center(
                                    child: CustomText(
                                      text: 'No data',
                                      style: AppTextStyles.body.copyWith(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : isVisitDetail
                                ? _visitRecordsList()
                                : _sessionRecordsList(),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _sessionRecordsList() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: AppSizes.pageInsets,
      children: [
        _VisitRecordCard(
          visit: visits.first,
          actionText: 'View',
          onAction: () {
            setState(() {
              isVisitDetail = true;
            });
          },
        ),
      ],
    );
  }

  Widget _visitRecordsList() {
    final packages = currentPatientData?.patient?.packages ?? [];
    final therapySessions = currentPatientData?.therapySessions ?? [];

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: AppSizes.pageInsets,
      children: [
        if (packages.isNotEmpty) ...[
          CustomText(text: 'Session Progress', style: AppTextStyles.name),
          SizedBox(height: AppSizes.spaceMd),
          ...List.generate(packages.length, (index) {
            final package = packages[index];
            final completedSessions = package.pivot?.sessionsUsed ?? 0;
            final totalSessions = package.sessions ?? 0;
            final hasTherapyAtIndex = index < therapySessions.length;
            final nextSessionDisplay = hasTherapyAtIndex
                ? therapySessions[index].displayNextSessionDate
                : 'No data';

            return SessionProgressCard(
              title: package.displayName.toSentenceCase,
              progressLabel: 'Progress',
              completedSessions: completedSessions,
              nextSessionLabel: totalSessions == completedSessions
                  ? 'Completed'
                  : !hasTherapyAtIndex || nextSessionDisplay == 'No data'
                  ? ''
                  : 'Next Session',
              nextSessionDate: totalSessions == completedSessions
                  ? ''
                  : !hasTherapyAtIndex
                  ? ''
                  : DateAndTimeFormater.dateFormat(
                      therapySessions[index].nextSessionDate,
                    ),
              totalSessions: totalSessions,
            );
          }),
          SizedBox(height: AppSizes.spaceXxl),
        ],
        CustomText(text: 'My Visits', style: AppTextStyles.name),
        SizedBox(height: AppSizes.spaceMd),
        ...List.generate(visits.length, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: AppSizes.spaceMd),
            child: _VisitRecordCard(
              visit: visits[index],
              actionText: 'Visit Details',
              onAction: () {
                final visit = visits[index];
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SessionNotes(
                      isConsultation: visit.isConsultationVisit,
                      visitId: visit.displayId,
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

class _VisitRecordCard extends StatelessWidget {
  const _VisitRecordCard({
    required this.visit,
    required this.actionText,
    required this.onAction,
  });

  final VisitModel visit;
  final String actionText;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        side: BorderSide(color: AppColors.borderColor),
      ),
      child: Padding(
        padding: AppSizes.cardInsets,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: visit.therapist != null
                            ? visit.therapist!.displayName
                            : 'No therapist',
                        style: AppTextStyles.name,
                        maxLines: 2,
                      ),
                      CustomText(
                        text: 'Physiotherapist',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: AppSizes.gapSm),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: AppSizes.iconSm,
                      color: AppColors.warning,
                    ),
                    SizedBox(width: AppSizes.gapSm),
                    CustomText(text: '4.5', style: AppTextStyles.body),
                  ],
                ),
              ],
            ),
            SizedBox(height: AppSizes.spaceXl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: DateAndTimeFormater.dateFormat(
                          visit.displayVisitAt.toString(),
                        ),
                        style: AppTextStyles.bodySmall,
                        maxLines: 1,
                      ),
                      CustomText(
                        text: visit.displayType,
                        style: AppTextStyles.bodySmall,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: AppSizes.gapMd),
                _RecordActionButton(text: actionText, onTap: onAction),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordActionButton extends StatelessWidget {
  const _RecordActionButton({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusSm);
    return Material(
      color: AppColors.bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: AppColors.primaryColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.gapMd,
            vertical: AppSizes.spaceSm,
          ),
          child: CustomText(
            text: text,
            style: AppTextStyles.chipPrimary.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
