import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'history_section_card_shell.dart';

/// Face: Eye Involvement
class FaceEyeInvolvementCard extends StatelessWidget {
  final String eyeClosureFully;
  final int eyeClosurePercent;
  final String eyeDryness;
  final int eyeDrynessPercent;

  const FaceEyeInvolvementCard({
    super.key,
    required this.eyeClosureFully,
    required this.eyeClosurePercent,
    required this.eyeDryness,
    required this.eyeDrynessPercent,
  });

  @override
  Widget build(BuildContext context) {
    if (eyeClosureFully.isNotEmpty ||
        eyeClosurePercent != 0 ||
        eyeDryness.isNotEmpty ||
        eyeDrynessPercent != 0) {
      return Padding(
        padding:  EdgeInsets.only(top: 12.0.h),
        child: HistorySectionCardShell(
          title: 'FACE: EYE INVOLVEMENT',
          child: Column(
            children: [
              eyeClosureFully != ''
                  ? HistoryFieldTile(
                      label: 'EYE CLOSURE FULLY',
                      value: eyeClosureFully,
                    )
                  : SizedBox(),
              SizedBox(height: 8.h),
              eyeClosurePercent != 0
                  ? HistoryFieldTile(
                      label: 'EYE CLOSURE %',
                      value: eyeClosurePercent == 0 ? '' : '$eyeClosurePercent%',
                    )
                  : SizedBox(),
              SizedBox(height: 8.h),
              eyeDryness != ''
                  ? HistoryFieldTile(label: 'EYE DRYNESS', value: eyeDryness)
                  : SizedBox(),
              SizedBox(height: 8.h),
              eyeDrynessPercent != 0
                  ? HistoryFieldTile(
                      label: 'EYE DRYNESS %',
                      value: eyeDrynessPercent == 0 ? '' : '$eyeDrynessPercent%',
                    )
                  : SizedBox(),
            ],
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
