import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

/// Household Work — web style card
/// Status: "yes" | "no"
/// Tasks: list — zyada items aayein to wrap
class HouseholdWorkCard extends StatelessWidget {
  final String status;
  final List<String> tasks;

  const HouseholdWorkCard({
    super.key,
    required this.status,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status.toLowerCase() == 'yes';
    final taskLabels = tasks.expand(_splitTask).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header('HOUSEHOLD WORK'),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 14.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _field(
                        'PERFORM HOUSEHOLD WORK?',
                        isActive ? 'Yes' : 'No',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label('SELECTED TASKS:'),
                          SizedBox(height: 6.h),
                          if (taskLabels.isEmpty)
                            Text(
                              '—',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mutedTextColor,
                              ),
                            )
                          else
                            Text(
                              taskLabels.map(_capitalize).join(', '),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.firstTextBlackColor,
                                height: 1.3,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// "cooking, meal_preparation" → ["cooking", "meal_preparation"]
  Iterable<String> _splitTask(String raw) {
    return raw
        .split(',')
        .map((e) => e.trim().replaceAll('_', ' '))
        .where((e) => e.isNotEmpty);
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value
        .split(' ')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  Widget _header(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.secondaryColor, AppColors.bgColor],
        ),
        border: Border(bottom: BorderSide(color: AppColors.borderColor)),
      ),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryColor,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 9.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.labelTextColor,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _field(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        SizedBox(height: 6.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.firstTextBlackColor,
          ),
        ),
      ],
    );
  }
}

/// Red Flags Screening — web style
/// Flags: [] → cleared banner, warna red chips list
class RedFlagsCard extends StatelessWidget {
  final List<String> flags;

  const RedFlagsCard({super.key, required this.flags});

  @override
  Widget build(BuildContext context) {
    // Sample API data

    final hasFlags = flags.isNotEmpty;

    return Column(
      children: [
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 14.h),
                child: hasFlags ? _flagsDetected(flags) : _clearedBanner(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.softRedBgColor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.softRedTextColor.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: const BoxDecoration(
              color: Color(0xFFC62828),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            'RED FLAGS SCREENING',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.softRedTextColor,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _clearedBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              size: 14.sp,
              color: AppColors.textWhiteColor,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'NO RED FLAGS DETECTED - Screening Cleared',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryColor,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _flagsDetected(List<String> flags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.softRedBgColor,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: AppColors.softRedTextColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 20.sp,
                color: AppColors.softRedTextColor,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  '${flags.length} RED FLAG(S) DETECTED',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.softRedTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: flags.map(_flagChip).toList(),
        ),
      ],
    );
  }

  Widget _flagChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.softRedBgColor,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: AppColors.softRedTextColor.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.softRedTextColor,
        ),
      ),
    );
  }
}
