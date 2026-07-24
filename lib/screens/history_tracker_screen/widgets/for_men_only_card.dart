import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'history_section_card_shell.dart';

/// For Men Only
class ForMenOnlyCard extends StatelessWidget {
  final String urinationPain;
  final String urineLeakage;
  final String nocturia;
  final String genitalNumbness;
  final String bladderOrSexualWorsening;

  const ForMenOnlyCard({
    super.key,
    required this.urinationPain,
    required this.urineLeakage,
    required this.nocturia,
    required this.genitalNumbness,
    required this.bladderOrSexualWorsening,
  });

  @override
  Widget build(BuildContext context) {
    final fields = <(String, String)>[
      ('URINATION PAIN', urinationPain),
      ('URINE LEAKAGE', urineLeakage),
      ('NOCTURIA', nocturia),
      ('GENITAL NUMBNESS', genitalNumbness),
      ('BLADDER / SEXUAL WORSENING', bladderOrSexualWorsening),
    ];

    if (urinationPain.isNotEmpty ||
        urineLeakage.isNotEmpty ||
        nocturia.isNotEmpty ||
        genitalNumbness.isNotEmpty ||
        bladderOrSexualWorsening.isNotEmpty) {
      return Padding(
        padding:  EdgeInsets.only(top: 12.0.h),
        child: HistorySectionCardShell(
          title: 'FOR MEN ONLY',
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
      return Container();
    }
  }
}
