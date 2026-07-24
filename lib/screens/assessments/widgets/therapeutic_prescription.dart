import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_styles/app_colors.dart';
import '../../../data/models/all_consutant_assessment_model.dart';
import 'section_header.dart';

class TherapeuticPrescriptionWidget extends StatelessWidget {
  final GeneralTherapeuticPrescription? prescription;

  const TherapeuticPrescriptionWidget({super.key, this.prescription});

  @override
  Widget build(BuildContext context) {
    final items = <({IconData icon, String title, String value})>[
      (
        icon: Icons.flash_on,
        title: 'ELECTROTHERAPY',
        value: prescription?.electrotherapy ?? '',
      ),
      (
        icon: Icons.opacity,
        title: 'THERMO / CRYOTHERAPY',
        value: prescription?.thermo ?? '',
      ),
      (
        icon: Icons.medical_services,
        title: 'ANTI-INFLAMMATORY MODALITIES',
        value: prescription?.antiInflammatory ?? '',
      ),
      (
        icon: Icons.science,
        title: 'ADVANCED TECHNIQUES',
        value: prescription?.advanced ?? '',
      ),
      (
        icon: Icons.medication,
        title: 'MEDICATIONS',
        value: prescription?.medications ?? '',
      ),
      (icon: Icons.spa, title: 'TOPICALS', value: prescription?.topicals ?? ''),
    ].where((e) => e.value.trim().isNotEmpty).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'THERAPEUTIC PRESCRIPTION'),
        if (items.isEmpty)
          Text(
            'No therapeutic prescription',
            style: TextStyle(fontSize: 12.sp, color: AppColors.labelTextColor),
          )
        else
          ...List.generate(items.length, (index) {
            final item = items[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == items.length - 1 ? 0 : 8.h,
              ),
              child: _buildTherapyItem(item.icon, item.title, item.value),
            );
          }),
      ],
    );
  }

  Widget _buildTherapyItem(IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.sectionBgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.labelTextColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.firstTextBlackColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
