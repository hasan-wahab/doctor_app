import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'history_section_card_shell.dart';

/// Face-Specific Pain
class FaceSpecificPainCard extends StatelessWidget {
  final String painPresent;
  final int intensity;
  final List<String> location;

  const FaceSpecificPainCard({
    super.key,
    required this.painPresent,
    required this.intensity,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    if (painPresent.isNotEmpty || intensity != 0 || location.isNotEmpty) {
      return Padding(
        padding:  EdgeInsets.only(top: 12.0.h),
        child: HistorySectionCardShell(
          title: 'FACE-SPECIFIC PAIN',
          child: Column(
            children: [
              painPresent != ''
                  ? HistoryFieldTile(label: 'PAIN PRESENT', value: painPresent)
                  : SizedBox(),
              SizedBox(height: 8.h),
              location.isNotEmpty
                  ? HistoryFieldTile(label: 'LOCATION', chips: location)
                  : SizedBox(),
              SizedBox(height: 8.h),
              intensity != 0
                  ? HistoryFieldTile(
                      label: 'INTENSITY',
                      value: intensity == 0 ? '' : '$intensity / 10',
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
