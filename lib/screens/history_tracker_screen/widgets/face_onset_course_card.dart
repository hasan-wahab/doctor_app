import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'history_section_card_shell.dart';

/// Face: Onset & Course
class FaceOnsetCourseCard extends StatelessWidget {
  const FaceOnsetCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    const onset = '';
    const duration = '';
    const course = <String>[];
    const coldExposure = '';

    return HistorySectionCardShell(
      title: 'FACE: ONSET & COURSE',
      child: Column(
        children: [
          HistoryFieldTile(label: 'ONSET', value: onset),
          SizedBox(height: 8.h),
          HistoryFieldTile(label: 'DURATION', value: duration),
          SizedBox(height: 8.h),
          HistoryFieldTile(label: 'COURSE', chips: course),
          SizedBox(height: 8.h),
          HistoryFieldTile(label: 'COLD EXPOSURE', value: coldExposure),
        ],
      ),
    );
  }
}
