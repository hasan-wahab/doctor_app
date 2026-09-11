import 'package:doctor_app/screens/assessments/assessment_detail_screen.dart';
import 'package:doctor_app/screens/history_tracker_screen/history_tracker_screen.dart';
import 'package:doctor_app/screens/seesion/sessiom_detail_screen.dart';
import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/app_styles/app_text_styles.dart';
import '../../widgets/app_empty_state.dart';
import '../../widgets/app_pull_refresh.dart';

class SessionNotes extends StatefulWidget {
  final String visitId;
  final bool isConsultation;

  const SessionNotes({
    super.key,
    this.visitId = '',
    this.isConsultation = false,
  });

  @override
  State<SessionNotes> createState() => _SessionNotesState();
}

class _SessionNotesState extends State<SessionNotes> {
  static const _tabs = ['History Tracker', 'Consultant', 'Therapy Session'];
  static const _tabIcons = [
    Icons.assignment_outlined,
    Icons.medical_information_outlined,
    Icons.spa_outlined,
  ];

  late int _tabIndex;
  bool _barLoading = false;

  @override
  void initState() {
    super.initState();
    _tabIndex = widget.isConsultation ? 0 : 2;
  }

  void _setBarLoading(bool value) {
    if (!mounted || _barLoading == value) return;
    setState(() => _barLoading = value);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<AppBarLoadingNotification>(
      onNotification: (notification) {
        _setBarLoading(notification.isLoading);
        return true;
      },
      child: Scaffold(
      backgroundColor: AppColors.screenBgColor,
      appBar: AppAppBar(
        title: 'Visit detail',
        showBack: true,
        isLoading: _barLoading,
      ),
      body: Column(
        children: [
          _VisitDetailTabs(
            labels: _tabs,
            icons: _tabIcons,
            selectedIndex: _tabIndex,
            onSelect: (index) {
              setState(() {
                _tabIndex = index;
                _barLoading = false;
              });
            },
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: KeyedSubtree(
                key: ValueKey(_tabIndex),
                child: _tabBody(),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _tabBody() {
    if (!widget.isConsultation && _tabIndex != 2) {
      return _tabIndex == 0
          ? AppEmptyState.historyTracker()
          : AppEmptyState.consultant();
    }

    switch (_tabIndex) {
      case 0:
        return HistoryTrackerScreen(
          key: ValueKey('history-${widget.visitId}'),
          visitId: widget.visitId,
          embedded: true,
        );
      case 1:
        return AssessmentDetailScreen(
          key: ValueKey('consultant-${widget.visitId}'),
          visitId: widget.visitId,
          embedded: true,
        );
      default:
        return SessionDetailScreen(
          key: ValueKey('therapy-${widget.visitId}'),
          visitId: widget.visitId,
          embedded: true,
        );
    }
  }
}

class _VisitDetailTabs extends StatelessWidget {
  const _VisitDetailTabs({
    required this.labels,
    required this.icons,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<String> labels;
  final List<IconData> icons;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        border: Border(
          bottom: BorderSide(color: AppColors.borderColor),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.pagePaddingH,
          AppSizes.spaceMd,
          AppSizes.pagePaddingH,
          AppSizes.spaceMd,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.spaceXs),
            child: Row(
              spacing: AppSizes.gapSm,
              children: List.generate(labels.length, (index) {
                final selected = index == selectedIndex;
                final radius = BorderRadius.circular(AppSizes.radiusSm);
                return Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      borderRadius: radius,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onSelect(index),
                        borderRadius: radius,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSizes.spaceSm,
                            horizontal: AppSizes.gapSm,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                icons[index],
                                size: AppSizes.iconSm,
                                color: selected
                                    ? AppColors.textWhiteColor
                                    : AppColors.mutedTextColor,
                              ),
                              SizedBox(height: AppSizes.spaceXs),
                              CustomText(
                                text: labels[index],
                                align: TextAlign.center,
                                maxLines: 2,
                                style: AppTextStyles.chipMuted.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: selected
                                      ? AppColors.textWhiteColor
                                      : AppColors.mutedTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
