import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
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
        height: MediaQuery.sizeOf(context).height.h,
        width: MediaQuery.sizeOf(context).width.w,
        color: AppColors.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            firstText == true
                ? Image.asset('assets/images/splash_icon.png')
                : Container(),
            SizedBox(height: 20),
            secondText == true
                ? Text(
                    'Y P A R Y A L I T A',
                    style: TextStyle(
                      color: AppColors.textWhiteColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Container(),
            thirdText == true
                ? Text(
                    'A L I T H E R A P Y',
                    style: TextStyle(
                      color: AppColors.textWhiteColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Container(),
            fourthText == true
                ? CustomText(
                    text: 'Your Health, Our Priority',
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> splashScreenNavigation() async {
    await Future.delayed(Duration(seconds: 2))
        .then((_) {
          firstText = true;
          setState(() {});
        })
        .then((_) async {
          await Future.delayed(Duration(seconds: 2)).then((_) {
            secondText = true;
            setState(() {});
          });
        })
        .then((_) async {
          await Future.delayed(Duration(seconds: 2))
              .then((_) {
                secondText = false;
                thirdText = true;
                setState(() {});
              })
              .then((_) async {
                await Future.delayed(Duration(seconds: 2))
                    .then((_) {
                      fourthText = true;
                      setState(() {});
                    })
                    .then((_) async {
                      await Future.delayed(Duration(seconds: 2)).then((_) {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.naveBar,
                        );
                      });
                    });
              });
        });
  }
}
