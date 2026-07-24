import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

/// Past Medical History & Previous Treatment
/// + Previous Investigations & Reports
class ClinicalBackgroundCard extends StatelessWidget {
  final List<String> medicalHistory;
  final List<String> medicalHistoryDetails;
  final String surgicalHistory;
  final List<String> previousTreatments;
  final Map<String?, String?> treatmentResponses;
  final List<String> investigationsDone;

  const ClinicalBackgroundCard({
    super.key,
    required this.medicalHistory,
    required this.medicalHistoryDetails,
    required this.surgicalHistory,
    required this.previousTreatments,
    required this.treatmentResponses,
    required this.investigationsDone,
  });

  @override
  Widget build(BuildContext context) {
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
              _header(),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   medicalHistory.isNotEmpty? _chipsTile('MEDICAL HISTORY', medicalHistory): SizedBox(),
                    SizedBox(height: 8.h),
                   medicalHistoryDetails.isNotEmpty? _chipsTile('MEDICAL HISTORY DETAILS', medicalHistoryDetails): SizedBox(),
                    SizedBox(height: 8.h),
                   surgicalHistory.isNotEmpty? _textTile('SURGICAL HISTORY', surgicalHistory): SizedBox(),
                    SizedBox(height: 8.h),
                    previousTreatments.isNotEmpty?_treatmentsTile(previousTreatments, treatmentResponses):SizedBox(),
                    SizedBox(height: 8.h),
                    investigationsDone.isNotEmpty? _chipsTile(
                      'INVESTIGATIONS DONE',
                      investigationsDone.map((e) => e.toUpperCase()).toList(),
                    ):SizedBox(),
                  ],
                ),
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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.secondaryColor, AppColors.bgColor],
        ),
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
            'CLINICAL BACKGROUND',
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

  Widget _tileShell({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: child,
    );
  }

  Widget _tileLabel(String label, {Color? color}) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 9.sp,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.labelTextColor,
        letterSpacing: 0.2,
        height: 1.2,
      ),
    );
  }

  Widget _emptyDash() {
    return Text(
      '—',
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.mutedTextColor,
      ),
    );
  }

  /// String value → text (empty → dash)
  Widget _textTile(String label, String value) {
    return _tileShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tileLabel(label),
          SizedBox(height: 8.h),
          value.trim().isEmpty
              ? _emptyDash()
              : Text(
                  value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.firstTextBlackColor,
                    height: 1.25,
                  ),
                ),
        ],
      ),
    );
  }

  /// List values → chips that wrap when more items arrive
  Widget _chipsTile(String label, List<String> items) {
    return _tileShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tileLabel(label),
          SizedBox(height: 8.h),
          if (items.isEmpty)
            _emptyDash()
          else
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: items.map(_miniChip).toList(),
            ),
        ],
      ),
    );
  }

  Widget _miniChip(String label) {
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

  /// Previous Treatments + Treatment Responses
  /// Har treatment ki apni row — list lambi ho to rows barh jayengi
  Widget _treatmentsTile(
    List<String> treatments,
    Map<String?, String?> responses,
  ) {
    return _tileShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tileLabel('PREVIOUS TREATMENTS'),
          SizedBox(height: 8.h),
          if (treatments.isEmpty)
            _emptyDash()
          else
            Column(
              children: [
                for (var i = 0; i < treatments.length; i++) ...[
                  if (i > 0) SizedBox(height: 6.h),
                  _treatmentRow(treatments[i], responses[treatments[i]]),
                ],
              ],
            ),
        ],
      ),
    );
  }

  Widget _treatmentRow(String treatment, String? response) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.softGrayColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              treatment,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.firstTextBlackColor,
              ),
            ),
          ),
          if (response != null && response.trim().isNotEmpty) ...[
            SizedBox(width: 8.w),
            _responseBadge(response),
          ],
        ],
      ),
    );
  }

  Widget _responseBadge(String response) {
    final improved = response.toLowerCase().contains('improve');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: improved ? AppColors.secondaryColor : AppColors.softRedBgColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            improved ? Icons.check : Icons.info_outline,
            size: 12.sp,
            color: improved
                ? AppColors.primaryColor
                : AppColors.softRedTextColor,
          ),
          SizedBox(width: 2.w),
          Text(
            response.toUpperCase(),
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w800,
              color: improved
                  ? AppColors.primaryColor
                  : AppColors.softRedTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
