import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/models/current_patient_model.dart';

class VisitsDetailScreen extends StatefulWidget {
  const VisitsDetailScreen({super.key});

  @override
  State<VisitsDetailScreen> createState() => _VisitsDetailScreenState();
}

class _VisitsDetailScreenState extends State<VisitsDetailScreen> {
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
        title: Text('My visit'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.bgColor,
      body: currentPatientData!.patient!.visits.isNotEmpty
          ? currentPatientData != null
                ? ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    children: [
                      CustomText(
                        text: 'Visit History',
                        fontSize: 20,
                        color: AppColors.primaryColor,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(
                          currentPatientData!.patient!.visits.length,
                          (index) {
                            final currentPatient =
                                currentPatientData!.patient!.visits;
                            return Container(
                              margin: EdgeInsets.only(top: 10.h),
                              height: 178.h,
                              width: 360.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                              ),

                              child: Card(
                                margin: EdgeInsets.zero,
                                color: AppColors.secondaryColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 12.h,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _text(
                                        firstText: 'Date',
                                        secondText:
                                            DateAndTimeFormater.dateFormat(
                                              currentPatient[index].visitAt
                                                  .toString(),
                                            ),
                                      ),
                                      _text(
                                        firstText: 'Type',
                                        buttonText: currentPatient[index].type
                                            .toString(),
                                      ),
                                      _text(
                                        firstText: 'Doctor',
                                        secondText:
                                            currentPatient[index].consultant ==
                                                null
                                            ? 'no data'
                                            : currentPatient[index]
                                                  .consultant!
                                                  .name,
                                      ),
                                      _text(
                                        firstText: 'Stage',
                                        secondText:
                                            currentPatient[index].currentStage,
                                      ),
                                      _text(
                                        firstText: 'Amount',
                                        secondText:
                                            currentPatient[index]
                                                .consultationFee
                                                .isNaN
                                            ? 'no data'
                                            : currentPatient[index]
                                                  .consultationFee
                                                  .toString(),
                                      ),
                                      _text(
                                        firstText: 'Status',
                                        buttonText:
                                            currentPatient[index].status ?? 'No data',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator())
          : Center(child: Text('No data')),
    );
  }

  Widget _text({
    required String firstText,
    String? secondText,
    String? buttonText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: CustomText(text: firstText)),
        Expanded(
          flex: 2,
          child: secondText != null
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
        ),
      ],
    );
  }
}
