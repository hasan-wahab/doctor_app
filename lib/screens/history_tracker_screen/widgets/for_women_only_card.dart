import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'history_section_card_shell.dart';

/// For Women Only
class ForWomenOnlyCard extends StatelessWidget {
  final String marriedSince;
  final String hasChildren;
  final String specialChild;
  final String isPregnant;
  final String pregnancyType;
  final String previousPregnancy;
  final String deliveryType;
  final String cycleRegular;
  final String cycleDescribe;
  final String periodDiscomfort;
  final String periodPainDescribe;
  final String gyneConditions;
  final String gyneDescribe;
  final String intercoursePain;
  final String hasIud;
  final String urineLeakage;
  final String nocturia;

  const ForWomenOnlyCard({
    super.key,
    required this.marriedSince,
    required this.hasChildren,
    required this.specialChild,
    required this.isPregnant,
    required this.pregnancyType,
    required this.previousPregnancy,
    required this.deliveryType,
    required this.cycleRegular,
    required this.cycleDescribe,
    required this.periodDiscomfort,
    required this.periodPainDescribe,
    required this.gyneConditions,
    required this.gyneDescribe,
    required this.intercoursePain,
    required this.hasIud,
    required this.urineLeakage,
    required this.nocturia,
  });

  @override
  Widget build(BuildContext context) {
    final fields = <(String, String)>[
      ('MARRIED SINCE', marriedSince),
      ('HAS CHILDREN', hasChildren),
      ('SPECIAL CHILD', specialChild),
      ('IS PREGNANT', isPregnant),
      ('PREGNANCY TYPE', pregnancyType),
      ('PREVIOUS PREGNANCY', previousPregnancy),
      ('DELIVERY TYPE', deliveryType),
      ('CYCLE REGULAR', cycleRegular),
      ('CYCLE DESCRIBE', cycleDescribe),
      ('PERIOD DISCOMFORT', periodDiscomfort),
      ('PERIOD PAIN DESCRIBE', periodPainDescribe),
      ('GYNE CONDITIONS', gyneConditions),
      ('GYNE DESCRIBE', gyneDescribe),
      ('INTERCOURSE PAIN', intercoursePain),
      ('HAS IUD', hasIud),
      ('URINE LEAKAGE', urineLeakage),
      ('NOCTURIA', nocturia),
    ];

    if (marriedSince.isNotEmpty ||
        hasChildren.isNotEmpty ||
        specialChild.isNotEmpty ||
        isPregnant.isNotEmpty ||
        pregnancyType.isNotEmpty ||
        previousPregnancy.isNotEmpty ||
        deliveryType.isNotEmpty ||
        cycleRegular.isNotEmpty ||
        cycleDescribe.isNotEmpty ||
        periodDiscomfort.isNotEmpty ||
        periodPainDescribe.isNotEmpty ||
        gyneConditions.isNotEmpty ||
        gyneDescribe.isNotEmpty ||
        intercoursePain.isNotEmpty ||
        hasIud.isNotEmpty ||
        urineLeakage.isNotEmpty ||
        nocturia.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 12.0.h),
        child: HistorySectionCardShell(
          title: 'FOR WOMEN ONLY',
          child: LayoutBuilder(
            builder: (context, constraints) {
              final gap = 8.w;
              final cols = constraints.maxWidth >= 520 ? 2 : 1;
              final tileW = (constraints.maxWidth - gap * (cols - 1)) / cols;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final field in fields)
                    SizedBox(
                      width: tileW,
                      child: HistoryFieldTile(label: field.$1, value: field.$2),
                    ),
                ],
              );
            },
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
