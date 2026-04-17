import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

class ProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isLeading;
  final VoidCallback? leadingOnTap;
  ProfileAppbar({
    super.key,
    required this.title,
    this.isLeading = false,
    this.leadingOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.secondaryColor,
      leading: isLeading
          ? InkWell(
              onTap:leadingOnTap?? () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new),
            )
          : null,

      centerTitle: true,
      title: Text(title),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(66.h);
}
