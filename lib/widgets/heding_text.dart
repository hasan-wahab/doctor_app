import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingText extends StatelessWidget {
  final String text;

  const HeadingText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: GoogleFonts.poppins.toString(),
        color: AppColors.firstTextBlackColor,
        fontWeight: FontWeight.w500,
        fontSize: 15.sp,
      ),
    );
  }
}
