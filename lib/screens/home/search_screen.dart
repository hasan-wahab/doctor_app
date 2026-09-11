import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(
        title: 'Search',
        showBack: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          children: [
            AppTField(
              autoFucus: true,
              hintText: 'Search therapists,payment..',
              icon: Icon(Icons.search),
              isIconsLeft: true,
            ),
          ],
        ),
      ),
    );
  }
}
