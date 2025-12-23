import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionNotes extends StatelessWidget {
  const SessionNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Visit detail'),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
      ),
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: List.generate((1), (index) {
                final totalSession = 7;
                final usedSession = 6;
                List colorsList = List.generate(
                  (usedSession == 0 ? 1 : usedSession),
                  (index) {
                    return usedSession != 0
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor;
                  },
                );
                List colorsList2 = List.generate((7 - usedSession), (index) {
                  return AppColors.secondaryColor;
                });
                return Container(
                  margin: EdgeInsets.only(top: 20.h),
                  padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 20),
                  height: 157.h,
                  width: 360.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(width: 2, color: AppColors.primaryColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'adsfsadf', fontSize: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Sessions Progress',
                            fontSize: 13,
                            color: AppColors.secondaryTextColor,
                          ),
                          CustomText(
                            text: '$usedSession/$totalSession',
                            fontSize: 12,
                          ),
                        ],
                      ),

                      Container(
                        height: 10.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [...colorsList, ...colorsList2],
                          ),

                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10.w,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _text(
                            firstText: 'Price',
                            secondText: 'currentPatientData',
                          ),
                          _text(firstText: 'Status', buttonText: 'jg'),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
            Container(
              width: double.infinity,
              height: 50.h,
              child: Card(
                child: Center(
                  child: CustomText(text: 'Assistant Manager Assessment'),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50.h,
              child: Card(
                child: Center(child: CustomText(text: 'Consultant Assessment')),
              ),
            ),

            Container(
              width: double.infinity,
              height: 50.h,
              child: Card(
                child: Center(child: CustomText(text: 'Therapy Session')),
              ),
            ),
          ],
        ),
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
}
