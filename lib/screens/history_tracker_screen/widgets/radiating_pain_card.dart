import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'history_section_card_shell.dart';

/// Radiating Pain (MANDATORY)
class RadiatingPainCard extends StatelessWidget {
  final String status;
  final List<String> radiationPath;
  final String radiationSide;

  const RadiatingPainCard({
    super.key,
    required this.status,
    required this.radiationPath,
    required this.radiationSide,
  });

  @override
  Widget build(BuildContext context) {
    if (status.isNotEmpty ||
        radiationPath.isNotEmpty ||
        radiationSide.isNotEmpty) {
      return Padding(
        padding:  EdgeInsets.only(top: 12.0.h),
        child: HistorySectionCardShell(
          title: 'RADIATING PAIN',
          child: Column(
            children: [
              status.isNotEmpty
                  ? HistoryFieldTile(
                      label: 'RADIATING STATUS',
                      value: status.isEmpty
                          ? ''
                          : status[0].toUpperCase() + status.substring(1),
                    )
                  : SizedBox(),
              SizedBox(height: 8.h),
              radiationPath.isNotEmpty
                  ? HistoryFieldTile(
                      label: 'RADIATION PATH',
                      chips: radiationPath,
                    )
                  : SizedBox(),
              SizedBox(height: 8.h),
              radiationSide.isNotEmpty
                  ? HistoryFieldTile(
                      label: 'RADIATION SIDE',
                      value: radiationSide,
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
