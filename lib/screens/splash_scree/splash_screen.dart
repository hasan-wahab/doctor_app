import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_update/in_app_update.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../widgets/custom_text.dart';
import '../home/bloc/home_bloc.dart';
import '../home/bloc/home_event.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _blockBecauseUpdate = false;
  String _updateMessage = '';
  bool _nativeSplashRemoved = false;

  static const _phoneLogo = 176.0;
  static const _phoneBrandHeight = 42.0;
  static const _phoneBottomInset = 32.0;

  static const _tabletLogo = 240.0;
  static const _tabletBrandHeight = 64.0;
  static const _tabletBottomInset = 48.0;

  @override
  void initState() {
    super.initState();
    splashScreenNavigation();
  }

  void _removeNativeSplash() {
    if (_nativeSplashRemoved) return;
    _nativeSplashRemoved = true;
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;
    final logoSize = isTablet ? _tabletLogo : _phoneLogo;
    final brandHeight = isTablet ? _tabletBrandHeight : _phoneBrandHeight;
    final bottomInset = isTablet ? _tabletBottomInset : _phoneBottomInset;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: logoSize,
                    height: logoSize,
                    child: Image.asset(
                      'assets/images/native_splash_logo.png',
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
                child: SizedBox(
                  height: brandHeight,
                  child: Image.asset(
                    'assets/images/native_splash_branding.png',
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ],
          ),
          if (_blockBecauseUpdate)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  24,
                  0,
                  24,
                  bottomInset + brandHeight + 16,
                ),
                child: CustomText(
                  text: _updateMessage,
                  color: AppColors.firstTextBlackColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> splashScreenNavigation() async {
    await _checkAndHandleUpdate();
    if (!mounted) return;

    // Required update: hide native splash so the message is visible.
    if (_blockBecauseUpdate) {
      _removeNativeSplash();
      return;
    }

    context.read<HomeBloc>().add(HomeLoadEvent());
    context.go(AppRoutes.naveBar);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _removeNativeSplash();
    });
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
