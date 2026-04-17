import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/custom_text.dart';

class SessionDetailScreen extends StatefulWidget {
  const SessionDetailScreen({super.key});

  @override
  State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends State<SessionDetailScreen> {
  CurrentPatientModel? currentPatientData;
  var therapySession;
  @override
  void didChangeDependencies() {
    Map<String, dynamic> data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if (data != null) {
      currentPatientData = data['data'];
      therapySession = data['therapySession'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
      //   ),
      //   centerTitle: true,
      //   title: Text('Sessions'),
      // ),
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text('Sessions'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        children: [
          CustomText(
            text: 'Therapy Sessions',
            fontSize: 20,
            color: AppColors.primaryColor,
          ),

          if (therapySession == null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                currentPatientData!.therapySessions.length,
                (index) {
                  var therapySessions =
                      currentPatientData!.therapySessions[index];
                  return Card(
                    color: AppColors.secondaryColor,
                    margin: EdgeInsets.only(top: 15.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 20.h,
                      ),

                      height: 178.h,
                      width: 360.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        //  border: Border.all(color: AppColors.primaryColor, width: 2),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _text(
                            firstText: 'Sessions#',
                            secondText: therapySessions.sessionNumber == null
                                ? 'No data'
                                : therapySessions.sessionNumber.toString(),
                          ),
                          _text(
                            firstText: 'Next session date',
                            secondText: DateAndTimeFormater.dateFormat(
                              therapySessions.nextSessionDate.toString(),
                            ),
                          ),
                          _text(
                            firstText: 'Therapist',
                            secondText: therapySessions.therapist!.name
                                .toString(),
                          ),

                          _text(
                            firstText: 'Duration',
                            secondText: therapySessions.durationSeconds
                                .toString(),
                          ),
                          _text(
                            firstText: 'Notes',
                            secondText: therapySessions.notes == ''
                                ? 'asd'
                                : therapySessions.notes,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: AppColors.secondaryColor,
                  margin: EdgeInsets.only(top: 15.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 20.h,
                    ),

                    height: 178.h,
                    width: 360.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      //  border: Border.all(color: AppColors.primaryColor, width: 2),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _text(
                          firstText: 'Sessions#',
                          secondText: therapySession.sessionNumber == null
                              ? 'No data'
                              : therapySession.sessionNumber.toString(),
                        ),
                        _text(
                          firstText: 'Next session date',
                          secondText: DateAndTimeFormater.dateFormat(
                            therapySession.nextSessionDate.toString(),
                          ),
                        ),
                        _text(
                          firstText: 'Therapist',
                          secondText: therapySession.therapist!.name.toString(),
                        ),

                        _text(
                          firstText: 'Duration',
                          secondText: therapySession.durationSeconds.toString(),
                        ),
                        _text(
                          firstText: 'Notes',
                          secondText: therapySession.notes == ''
                              ? 'no data'
                              : therapySession.notes,
                        ),
                      ],
                    ),
                  ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomText(text: firstText, color: AppColors.primaryColor),
        ),
        Expanded(
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
