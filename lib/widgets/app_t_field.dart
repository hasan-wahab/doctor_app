import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String? value)? validator;
  final double? width;
  final Widget? icon;
  final bool isIconsLeft;
  final bool obscureText;
  final bool autoFucus;
  const AppTField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.width,
    this.icon,
    this.isIconsLeft = true,
    this.obscureText=false,
    this.autoFucus=false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 62.h,
          width: width ?? MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(217, 217, 217, 0.35),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: TextFormField(
            autofocus: autoFucus,
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              // icon: Icon(Icons.add),
              //  suffix: Icon(Icons.add),
              contentPadding: EdgeInsets.only(top: 20, left:isIconsLeft==false?20: 40, right: 20),
              border: InputBorder.none,
              hintText: '${hintText ?? ''}',

              // label: Text(lableText),
            ),
            validator: (value) => validator!(value) ?? null,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: isIconsLeft == false ? 10.w : 0,
            left: isIconsLeft == true ? 10.w : 0,
          ),
          child: Align(
            alignment: isIconsLeft == true
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child:  icon,
          ),
        ),
      ],
    );
  }
}
