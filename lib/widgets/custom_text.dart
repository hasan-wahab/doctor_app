import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final int? maxLines;
  final TextAlign? align;
  final TextOverflow textOverflow;
  final TextStyle ?style;

  const CustomText({
    super.key,
    this.style,
    required this.text,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w500,
    this.color = Colors.black,
    this.maxLines,
    this.align,
    this.textOverflow =TextOverflow.ellipsis
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow:textOverflow,
      maxLines: maxLines,
      textAlign: align,
      text,
      style:style?? TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
        fontFamily: GoogleFonts.poppins.toString(),
      ),
    );
  }
}
