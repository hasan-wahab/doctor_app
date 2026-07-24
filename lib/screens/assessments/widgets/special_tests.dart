import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_styles/app_colors.dart';
import '../../../data/models/all_consutant_assessment_model.dart';
import 'section_header.dart';

class SpecialTestsWidget extends StatefulWidget {
  Map<String, List<SpecialTest>> specialTests = {};

  SpecialTestsWidget({super.key, required this.specialTests});

  @override
  State<SpecialTestsWidget> createState() => _SpecialTestsWidgetState();
}

class _SpecialTestsWidgetState extends State<SpecialTestsWidget> {
  bool isExpended = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'SPECIAL TESTS EXAMINATION'),
        Column(
          children: List.generate((widget.specialTests.length), (index) {
            return widget.specialTests.values.toList()[index].isNotEmpty
                ? Container(
                    margin: EdgeInsets.only(
                      bottom:
                          widget.specialTests.values.toList()[index].isNotEmpty
                          ? 5
                          : 0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.softGrayColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.r),
                              topRight: Radius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            widget.specialTests.keys.toList()[index],
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.labelTextColor,
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(
                            (widget
                                .specialTests[widget.specialTests.keys
                                    .toList()[index]]!
                                .length),
                            (index2) {
                              return _buildTestRow(
                                widget
                                        .specialTests[widget.specialTests.keys
                                            .toList()[index]]![index2]
                                        .test
                                        ?.toString() ??
                                    '',
                                widget
                                        .specialTests[widget.specialTests.keys
                                            .toList()[index]]![index2]
                                        .result
                                        ?.toString() ??
                                    '',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox();
          }),
        ),
      ],
    );
  }

  Widget _buildTestRow(String testName, String result) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              testName,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.firstTextBlackColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: result != 'POSITIVE'
                  ? AppColors.softRedBgColor
                  : AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              result,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: result != 'POSITIVE'
                    ? AppColors.softRedTextColor
                    : AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
