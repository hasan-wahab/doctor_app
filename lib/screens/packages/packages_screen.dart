import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_styles/app_colors.dart';
import '../../models/current_patient_model.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/date_time_foemat.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  CurrentPatientModel? currentPatientData;
  @override
  void didChangeDependencies() {
    Map<String, CurrentPatientModel> data =
        ModalRoute.of(context)?.settings.arguments
            as Map<String, CurrentPatientModel>;
    if (data != null) {
      currentPatientData = data['data'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text('Packages'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        children: [
          CustomText(
            text: 'Treatment Packages',
            fontSize: 20,
            color: AppColors.primaryColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Session Progress
              SizedBox(height: 10.h),
              ...List.generate(
                currentPatientData!.patient!.packages.isNotEmpty
                    ? currentPatientData!.patient!.packages.length
                    : 1,

                (index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.h),

                    height: 110.h,
                    width: 360.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Card(
                      color: AppColors.secondaryColor,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.h,
                          vertical: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text:
                                  currentPatientData!.patient!.packages.isEmpty
                                  ? 'No Data'
                                  : currentPatientData!
                                        .patient!
                                        .packages[index]
                                        .name.toString(),
                              fontSize: 12,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Sessions Progress',
                                  fontSize: 12,
                                  color: AppColors.secondaryTextColor,
                                ),
                                CustomText(
                                  text:
                                      '${currentPatientData!.patient!.packages.isNotEmpty ? currentPatientData!.patient!.packages[index].pivot!.sessionsTotal : 0}/${currentPatientData!.patient!.packages.isNotEmpty ? currentPatientData!.patient!.packages[index].pivot!.sessionsUsed : 0}',
                                  fontSize: 10,
                                ),
                              ],
                            ),

                            LinearProgressIndicator(
                              value:
                                  currentPatientData!.patient!.packages.isEmpty
                                  ? 1.0
                                  : getSessionProgress(index),
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.primaryColor,
                              ),
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Next Session Date',
                                  fontSize: 15,
                                ),
                                CustomText(
                                  text:
                                      currentPatientData!
                                          .patient!
                                          .packages
                                          .isNotEmpty
                                      ? DateAndTimeFormater.dateFormat(
                                          currentPatientData!
                                              .therapySessions
                                              .first
                                              .nextSessionDate
                                              .toString(),
                                        )
                                      : 'No data',
                                  fontSize: 12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _text({
    required String firstText,
    String? secondText,
    String? buttonText,
  }) {
    return Column(
      spacing: 5.h,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: firstText),
        secondText != null
            ? CustomText(text: secondText, align: TextAlign.start)
            : Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 1.h,
                    ),
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: CustomText(
                      text: buttonText!,
                      color: AppColors.textWhiteColor,
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  double getSessionProgress(int index) {
    final total =
        currentPatientData!.patient!.packages[index].pivot!.sessionsTotal;
    final used =
        currentPatientData!.patient!.packages[index].pivot!.sessionsUsed;

    if (total == 0) return 0.0;

    final progress = used! / total!;

    if (progress.isNaN || progress.isInfinite) return 0.0;

    return progress.clamp(0.0, 1.0);
  }
}
