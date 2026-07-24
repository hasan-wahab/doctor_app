import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'history_section_card_shell.dart';

/// Associated Symptoms
class AssociatedSymptomsCard extends StatelessWidget {
  final List<String> symptoms;
  const AssociatedSymptomsCard({super.key, required this.symptoms});

  @override
  Widget build(BuildContext context) {
    if (symptoms.isNotEmpty) {
      return Padding(
        padding:  EdgeInsets.only(top: 12.0.h),
        child: HistorySectionCardShell(
          title: 'ASSOCIATED SYMPTOMS',
          child: HistoryFieldTile(label: 'SYMPTOMS', chips: symptoms),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
