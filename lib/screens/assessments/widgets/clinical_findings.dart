import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_styles/app_colors.dart';
import 'section_header.dart';

class ClinicalFindingWidget extends StatelessWidget {
  List<String> tags = [];
  String notes;
  ClinicalFindingWidget({super.key, required this.tags, this.notes = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'CLINICAL FINDINGS & DIAGNOSIS'),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: tags.map((tag) => _buildTag(tag)).toList(),
        ),
        SizedBox(height: 16.h),
        Text(
          'NOTES',
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.labelTextColor,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          notes.toString(),
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.firstTextBlackColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.diagnosisRedColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
