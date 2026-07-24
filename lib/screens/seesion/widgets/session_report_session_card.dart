import 'package:doctor_app/screens/seesion/widgets/session_report_patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'session_report_modality_body.dart';
import 'session_report_session_body.dart';

class SessionReportSessionCard extends StatelessWidget {
  final String sessionNumber;
  final String packageUsed;
  final String sessionDuration;
  final String visitDate;
  final String startedAt;
  final String endedAt;
  final int modalityLength = 0;
  final String terapistName;
  final String patientName;
  final String cnic;
  final String ageGender;
  final List<ModalityEntity> modalities;

  const SessionReportSessionCard({
    this.sessionNumber = '',
    this.packageUsed = '',
    this.sessionDuration = '',
    this.visitDate = '',
    this.startedAt = '',
    this.endedAt = '',
    super.key,
    this.terapistName = '',
    this.patientName = '',
    this.cnic = '',
    this.ageGender = '',
    required this.modalities,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SessionReportSessionBody(
          terapistName: terapistName,
          patientName: patientName,
          cnic: cnic,
          gender: ageGender,
          startedAt: startedAt,
          endedAt: endedAt,
          packageUsed: packageUsed,
          sessionDuration: sessionDuration,
          sessionNumber: sessionNumber,
          visitDate: visitDate,
          modalities: modalities,
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
