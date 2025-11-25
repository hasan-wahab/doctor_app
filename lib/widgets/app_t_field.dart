import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String? value)? validator;
  final double? width;
  const AppTField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.h,
      width: width ?? MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(217, 217, 217, 0.35),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          // icon: Icon(Icons.add),
          //  suffix: Icon(Icons.add),
          contentPadding: EdgeInsets.only(top: 20, left: 20, right: 20),
          border: InputBorder.none,
          hintText: hintText ?? "",

          // label: Text(lableText),
        ),
        validator: (value) => validator!(value) ?? null,
      ),
    );
  }
}
