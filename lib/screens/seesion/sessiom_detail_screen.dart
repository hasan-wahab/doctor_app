
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_styles/app_colors.dart';
import '../../widgets/custom_text.dart';

class SessionDetailScreen extends StatelessWidget {
  const SessionDetailScreen({super.key});

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
        title: Text('Sessions'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        children: [
          CustomText(
            text: 'Therapy Sessions',
            fontSize: 20,
            color: AppColors.primaryColor,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(6, (index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                margin: EdgeInsets.only(top: 10.h),
                height: 178.h,
                width: 360.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primaryColor, width: 2),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _text(firstText: 'Sessions#', secondText: '#0000002'),
                    _text(firstText: 'Date', secondText: 'Nov 29, 2025'),
                    _text(firstText: 'Therapist', secondText: 'Dr Danyal Muhammad'),

                    _text(firstText: 'Duration', secondText: '00:00:08'),
                    _text(firstText: 'Notes', secondText: 'asdfasdf'),
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
