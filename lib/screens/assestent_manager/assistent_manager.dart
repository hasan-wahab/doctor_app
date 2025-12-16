import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_styles/app_colors.dart';
import '../../widgets/custom_text.dart';

class AssistantManagerScreen extends StatelessWidget {
  const AssistantManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
        centerTitle: true,
        title: Text('Assistant manager'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        children: [
          CustomText(
            text: 'Assistant Manager Assessment',
            fontSize: 20,
            color: AppColors.primaryColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(6, (index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                margin: EdgeInsets.only(top: 10.h),
                height: 420.h,
                width: 360.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primaryColor, width: 2),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _text(
                      firstText: 'Visit Date #',
                      secondText: 'Nov 29, 2025',
                    ),
                    _text(firstText: 'AM Name', secondText: 'dr sonia ahmed'),
                    _text(
                      firstText: 'Consultant',
                      secondText: 'Dr Danyal Muhammad',
                    ),

                    _text(firstText: 'Occupation', secondText: 'N/A'),
                    _text(firstText: 'Chief Complaint', secondText: 'asdfasdf'),
                    _text(firstText: 'Complaint Onset', secondText: 'N/A'),
                    _text(firstText: 'Pain Severity', secondText: 'N/A'),
                    _text(firstText: 'Pain Type', secondText: 'N/A'),

                    _text(firstText: 'Pain Location', secondText: 'N/A'),
                    _text(firstText: 'Pain Radiation', secondText: 'N/A'),
                    _text(firstText: 'Aggravating Factors', secondText: 'N/A'),
                    _text(
                      firstText: 'Relieving Factors',
                      secondText: 'asdfasdf',
                    ),
                    _text(firstText: 'Functional Impact', secondText: 'N/A'),
                    _text(
                      firstText: 'Red Flags',
                      buttonText: '1',
                      buttonColor: Colors.red,
                    ),
                    _text(
                      firstText: 'Consent',
                      buttonText: 'Pending',
                      buttonColor: Colors.yellow,
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _text({
    required String firstText,
    String? secondText,
    String? buttonText,
    Color? buttonColor,
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
                        color: buttonColor ?? AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: CustomText(
                        text: buttonText!,
                        color: buttonColor == Colors.yellow
                            ? AppColors.firstTextBlackColor
                            : AppColors.textWhiteColor,
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
