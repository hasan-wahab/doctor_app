import 'package:doctor_app/screens/seesion/widgets/session_report_patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';
import 'session_report_modality_body.dart';

class SessionReportSessionBody extends StatelessWidget {
  final String sessionNumber;
  final String packageUsed;
  final String sessionDuration;
  final String visitDate;
  final String startedAt;
  final String endedAt;

  final String patientName;
  final String cnic;
  final String gender;
  final String terapistName;
  List<ModalityEntity> modalities;

  SessionReportSessionBody({
    super.key,
    this.terapistName = '',
    this.sessionNumber = '',
    this.packageUsed = '',
    this.sessionDuration = '',
    this.visitDate = '',
    this.startedAt = '',
    this.endedAt = '',
    this.patientName = '',
    this.cnic = '',
    this.gender = '',
    required this.modalities,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SessionReportPatientCard(
            patientName: patientName,
            cnic: cnic,
            gender: gender,
            attendingTherapist: terapistName,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Text(
                'SESSION # $sessionNumber',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryColor,
                ),
              ),
              const Spacer(),
              _packageBadge(packageUsed),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _metric('SESSION DURATION', sessionDuration)),
              Expanded(child: _metric('VISIT DATE', visitDate)),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(child: _metric('STARTED AT', startedAt)),
              Expanded(child: _metric('ENDED AT', endedAt)),
            ],
          ),
          SizedBox(height: 16.h),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MODALITIES & TECHNIQUES PERFORMED',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryColor,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 12.h),
              ...List.generate((modalities.length), (index) {
                return SessionReportModalityTile(
                  title: modalities[index].title,
                  duration: modalities[index].duration,
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _packageBadge(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.softRedBgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.softRedTextColor,
        ),
      ),
    );
  }

  Widget _metric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.labelTextColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.firstTextBlackColor,
          ),
        ),
      ],
    );
  }
}

class ModalityEntity {
  final String title;
  final String duration;
  ModalityEntity({required this.title, required this.duration});
}
