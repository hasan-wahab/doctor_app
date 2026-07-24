import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

/// Shared shell used by history-taker section cards
class HistorySectionCardShell extends StatelessWidget {
  final String title;
  final Widget child;
  final Color? accentColor;
  final Color? headerBgColor;

  const HistorySectionCardShell({
    super.key,
    required this.title,
    required this.child,
    this.accentColor,
    this.headerBgColor,
  });

  @override
  Widget build(BuildContext context) {
    final accent = accentColor ?? AppColors.primaryColor;

    return Container(
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: headerBgColor ?? AppColors.secondaryColor,
              border: Border(bottom: BorderSide(color: AppColors.borderColor)),
            ),
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                      color: accent,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 14.h),
            child: child,
          ),
        ],
      ),
    );
  }
}

class HistoryFieldTile extends StatelessWidget {
  final String label;
  final String? value;
  final List<String>? chips;
  final Color? labelColor;

  const HistoryFieldTile({
    super.key,
    required this.label,
    this.value,
    this.chips,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final hasChips = chips != null;
    final text = value?.trim() ?? '';
    final chipItems = chips ?? const <String>[];

    return value != ''
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                    color: labelColor ?? AppColors.labelTextColor,
                    letterSpacing: 0.2,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 8.h),
                if (hasChips)
                  chipItems.isEmpty
                      ? _dash()
                      : Wrap(
                          spacing: 6.w,
                          runSpacing: 6.h,
                          children: chipItems.map(_chip).toList(),
                        )
                else
                  text.isEmpty
                      ? _dash()
                      : Text(
                          text,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.firstTextBlackColor,
                            height: 1.25,
                          ),
                        ),
              ],
            ),
          )
        : SizedBox();
  }

  Widget _dash() {
    return Text(
      '—',
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.mutedTextColor,
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.softGrayColor,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.firstTextBlackColor,
        ),
      ),
    );
  }
}
