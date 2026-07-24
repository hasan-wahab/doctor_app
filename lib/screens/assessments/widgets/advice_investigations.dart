import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_styles/app_colors.dart';
import 'section_header.dart';

class AdviceInvestigationsWidget extends StatelessWidget {
  final List investigationsDone;
  final String otherInvestigationsAdvice;

  const AdviceInvestigationsWidget({
    super.key,
    required this.investigationsDone,
    required this.otherInvestigationsAdvice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'ADVICE & INVESTIGATIONS'),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.sectionBgColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INVESTIGATIONS DONE',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.labelTextColor,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: List.generate((investigationsDone.length), (index) {
                  return _buildSmallTag(investigationsDone[index].toString());
                }),
              ),
              SizedBox(height: 16.h),
              Text(
                'OTHER INVESTIGATIONS / ADVICE',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.labelTextColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                otherInvestigationsAdvice,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.firstTextBlackColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
