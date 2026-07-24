import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_styles/app_colors.dart';
import '../../../data/models/all_consutant_assessment_model.dart';
import 'section_header.dart';

class MuscleAssessmentsWidget extends StatelessWidget {
  final List<MuscleAssessment> muscleAssessments;

  const MuscleAssessmentsWidget({
    super.key,
    required this.muscleAssessments,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'MUSCLE ASSESSMENTS / EXERCISES'),
        if (muscleAssessments.isEmpty)
          Text(
            'No muscle assessments',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.labelTextColor,
            ),
          )
        else
          ...List.generate(muscleAssessments.length, (index) {
            final item = muscleAssessments[index];
            final exercises = item.prescribedExercises
                .map((e) => '${e.name ?? ''} (${e.dosage ?? ''})'.trim())
                .where((e) => e.isNotEmpty && e != '()')
                .join('\n');

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == muscleAssessments.length - 1 ? 0 : 12.h,
              ),
              child: _buildMuscleBlock(
                item.muscle ?? '',
                item.conditionStatus.join(', '),
                item.manualTreatment.join(', '),
                exercises.isEmpty ? '-' : exercises,
                extraContent: item.defaultExercises.isEmpty
                    ? null
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          Text(
                            'By Default Exercises',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.labelTextColor,
                            ),
                          ),
                          Text(
                            item.defaultExercises.join('\n'),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.firstTextBlackColor,
                            ),
                          ),
                          if ((item.otherTreatment ?? '').isNotEmpty) ...[
                            SizedBox(height: 8.h),
                            Text(
                              'Other Treatment',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.labelTextColor,
                              ),
                            ),
                            Text(
                              item.otherTreatment!,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: AppColors.labelTextColor,
                              ),
                            ),
                          ],
                        ],
                      ),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildMuscleBlock(
    String muscle,
    String condition,
    String treatment,
    String exercises, {
    Widget? extraContent,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.softGrayColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
            ),
            child: Text(
              muscle,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.labelTextColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Condition',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.labelTextColor,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        condition.isEmpty ? '-' : condition,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Manual Treatment',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.labelTextColor,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        treatment.isEmpty ? '-' : treatment,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  'Prescribed Exercises',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  exercises,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.firstTextBlackColor,
                  ),
                ),
                if (extraContent != null) extraContent,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
