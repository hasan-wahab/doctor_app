import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class RowText extends StatelessWidget {
  final String firstText;
  final String? secondText;
  final String? buttonText;
  const RowText({
    super.key,
    required this.firstText,
    this.secondText,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return text(
      firstText: firstText,
      secondText: secondText,
      buttonText: buttonText,
    );
  }

  Widget text({
    required String firstText,
    String? secondText,
    String? buttonText,
  }) {
    if (secondText.toString().isNotEmpty &&
        secondText != 'No data' &&
        secondText != 'null' &&
        secondText != null &&
        secondText.contains("[]") == false) {
      // Remove the square brackets from the string
      final cleanText = secondText.replaceAll('[', '').replaceAll(']', '');
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: CustomText(text: firstText, fontSize: 12)),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomText(
                text: cleanText,
                align: TextAlign.start,
                fontSize: 12,
                maxLines: 5,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      );
    } else if (buttonText.toString().isNotEmpty &&
        buttonText != 'No data' &&
        buttonText != 'No data' &&
        buttonText != null &&
        buttonText.contains("[]") == false) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomText(
                text: firstText,
                fontSize: 12,
                color: firstText == 'Red Flags' ? Colors.red : Colors.black,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomText(
                text: buttonText,
                align: TextAlign.start,
                fontSize: 12,
                maxLines: 5,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
