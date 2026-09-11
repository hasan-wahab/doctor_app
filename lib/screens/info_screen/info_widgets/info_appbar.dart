import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';

class AboutTheropyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AboutTheropyAppBar({super.key});

  @override
  Size get preferredSize => AppAppBar.barSize;

  @override
  Widget build(BuildContext context) {
    return const AppAppBar(
      title: 'About Ali Therapy',
      showBack: true,
    );
  }
}
