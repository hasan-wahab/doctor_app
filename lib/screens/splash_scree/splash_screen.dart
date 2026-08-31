import 'package:doctor_app/screens/nave_bar/nave_bar.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../home/bloc/home_bloc.dart';
import '../home/bloc/home_event.dart';
import 'package:in_app_update/in_app_update.dart';

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

  bool _blockBecauseUpdate = false;
  String _updateMessage = '';

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
            if (_blockBecauseUpdate)
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: CustomText(
                  text: _updateMessage,
                  color: AppColors.textWhiteColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> splashScreenNavigation() async {
    await _checkAndHandleUpdate();
    if (!mounted) return;
    if (_blockBecauseUpdate) return;

    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    context.read<HomeBloc>().add(HomeLoadEvent());
    context.go(AppRoutes.naveBar);
  }

  Future<void> _checkAndHandleUpdate() async {
    if (!Platform.isAndroid) return;

    try {
      final info = await InAppUpdate.checkForUpdate();

      final isUpdateAvailable =
          info.updateAvailability == UpdateAvailability.updateAvailable;

      // "Required update" we treat as immediate update allowed.
      if (isUpdateAvailable && info.immediateUpdateAllowed == true) {
        final result = await InAppUpdate.performImmediateUpdate();

        if (result != AppUpdateResult.success) {
          if (!mounted) return;
          setState(() {
            _blockBecauseUpdate = true;
            _updateMessage =
                'Update required. Please update from Play Store to continue.';
          });
        }
      }
    } catch (e) {
      // If update check fails, don't block the app.
      debugPrint('In-app update check failed: $e');
    }
  }
}
