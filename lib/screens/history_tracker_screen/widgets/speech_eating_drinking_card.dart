import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'history_section_card_shell.dart';

/// Speech, Eating & Drinking
class SpeechEatingDrinkingCard extends StatelessWidget {
  final List<String> assessment;

  const SpeechEatingDrinkingCard({super.key, required this.assessment});

  @override
  Widget build(BuildContext context) {
    if (assessment.isNotEmpty) {
      return Padding(
        padding:  EdgeInsets.only(top: 12.0.h),
        child: HistorySectionCardShell(
          title: 'SPEECH, EATING & DRINKING',
          child: HistoryFieldTile(label: 'ASSESSMENT', chips: assessment),
        ),
      );
    }else{
      return SizedBox();
    }
  }
}
