import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/local_storage/local_storage.dart';
import 'package:doctor_app/screens/nave_bar/nave_bar.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool firstText = false;
  bool secondText = false;
  bool thirdText = false;
  bool fourthText = false;

  @override
  void initState() {
    splashScreenNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        color: AppColors.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //  height: 100.h,
              width: 300.w,
              child: Image.asset("assets/images/main_logo.png"),
            ),
            SizedBox(height: 20),

            Text(
              'A L I T H E R A P Y',
              style: TextStyle(
                color: AppColors.textWhiteColor,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),

            CustomText(
              text: 'Your Health, Our Priority',
              color: Color.fromRGBO(255, 255, 255, 0.8),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> splashScreenNavigation() async {
    await Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.pushReplacementNamed(context, AppRoutes.naveBar);
    });
  }
}
