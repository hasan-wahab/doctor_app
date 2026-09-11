import 'dart:io';

import 'package:doctor_app/screens/auth_screen/login_screen/login_screen.dart';
import 'package:doctor_app/screens/dashboard_screen/dashbord_screen.dart';
import 'package:doctor_app/screens/home/home_screen.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:doctor_app/screens/nfc_card/nfc_card.dart';
import 'package:doctor_app/screens/profile_screens/profile_screen.dart';
import 'package:doctor_app/screens/session_record/session_record.dart';
import 'package:doctor_app/widgets/app_shimmer.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:in_app_update/in_app_update.dart';

import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/app_styles/app_text_styles.dart';
import '../../core/functions.dart';
import 'bloc/nave_bar_state.dart';

class NaveBar extends StatefulWidget {
  NaveBar({super.key});

  @override
  State<NaveBar> createState() => _NaveBarState();
}

class _NaveBarState extends State<NaveBar> {
  late final List<String> iconText;
  late final List<IconData> icons;
  late final List<Widget> screenList;
  late final List<Widget> screenList2;
  late final int accountTabIndex;

  @override
  void initState() {
    super.initState();
    if (showNfcCard) {
      iconText = ['Home', 'My card', 'Records', 'Account'];
      icons = [
        Icons.home_rounded,
        Icons.credit_card_outlined,
        Icons.assignment_outlined,
        Icons.person_outline_rounded,
      ];
      screenList = [
        HomeScreen(),
        NfcCardPage(),
        SessionRecord(),
        LoginScreen(),
      ];
      screenList2 = [
        DashbordScreen(),
        NfcCardPage(),
        SessionRecord(),
        ProfileScreen(),
      ];
    } else {
      // iPhone / iOS: never show the NFC card tab.
      iconText = ['Home', 'Records', 'Account'];
      icons = [
        Icons.home_rounded,
        Icons.assignment_outlined,
        Icons.person_outline_rounded,
      ];
      screenList = [
        HomeScreen(),
        SessionRecord(),
        LoginScreen(),
      ];
      screenList2 = [
        DashbordScreen(),
        SessionRecord(),
        ProfileScreen(),
      ];
    }
    accountTabIndex = iconText.length - 1;
    context.read<NaveBarBloc>().add(NaveBarIndexEvent(index: 0));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
    _checkAndHandleUpdate();
  }

  Future<void> _checkAndHandleUpdate() async {
    if (!Platform.isAndroid) return;
    try {
      final info = await InAppUpdate.checkForUpdate();
      final isUpdateAvailable =
          info.updateAvailability == UpdateAvailability.updateAvailable;
      if (isUpdateAvailable && info.immediateUpdateAllowed == true) {
        final result = await InAppUpdate.performImmediateUpdate();
        if (result != AppUpdateResult.success && mounted) {
          setState(() {
            _blockBecauseUpdate = true;
            _updateMessage =
                'Update required. Please update from Play Store to continue.';
          });
        }
      }
    } catch (e) {
      debugPrint('In-app update check failed: $e');
    }
  }

  bool isLoading = false;
  int currentIndex = 0;
  String? token = '';
  bool _blockBecauseUpdate = false;
  String _updateMessage = '';
  @override
  Widget build(BuildContext context) {
    if (_blockBecauseUpdate) {
      return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Center(
          child: Padding(
            padding: AppSizes.pageInsets,
            child: CustomText(
              text: _updateMessage,
              align: TextAlign.center,
              color: AppColors.firstTextBlackColor,
            ),
          ),
        ),
      );
    }

    return BlocConsumer<NaveBarBloc, NaveBarState>(
      listener: (context, state) {
        if (state is NaveBarMessageState) {
          isLoading = false;
          AppMsg.showSnackBar(context, message: state.message!);
        }
        if (state is NaveBarLoadingState) {
          isLoading = true;
        }
        if (state is NaveBarIndexState) {
          isLoading = false;
          currentIndex = state.index;
          token = state.token;
          print(token);
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            if (currentIndex != 0) {
              context.read<NaveBarBloc>().add(NaveBarIndexEvent(index: 0));
            } else {
              SystemNavigator.pop();
            }
          },
          child: isLoading == false
            ? Scaffold(
                body: token == ''
                    ? screenList.elementAt(currentIndex)
                    : screenList2.elementAt(currentIndex),
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.firstTextBlackColor.withValues(
                          alpha: 0.06,
                        ),
                        blurRadius: 12,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppSizes.pagePaddingH,
                        AppSizes.spaceSm,
                        AppSizes.pagePaddingH,
                        AppSizes.spaceSm,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(iconText.length, (index) {
                          final isSelected = currentIndex == index;
                          return InkWell(
                            onTap: () {
                              if (token == '') {
                                context.read<NaveBarBloc>().add(
                                  NaveBarIndexEvent(
                                    index: index == 0
                                        ? index
                                        : accountTabIndex,
                                  ),
                                );
                                if (index != 0 && index != accountTabIndex) {
                                  AppMsg.warning(
                                    context,
                                    'Please sign in first to open this section.',
                                  );
                                }
                              } else {
                                context.read<NaveBarBloc>().add(
                                  NaveBarIndexEvent(index: index),
                                );
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.gapSm,
                                vertical: AppSizes.spaceXs,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    icons[index],
                                    size: AppSizes.iconLg,
                                    color: isSelected
                                        ? AppColors.primaryColor
                                        : AppColors.mutedTextColor,
                                  ),
                                  SizedBox(height: AppSizes.spaceXs),
                                  CustomText(
                                    text: iconText[index],
                                    style: AppTextStyles.label.copyWith(
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? AppColors.primaryColor
                                          : AppColors.mutedTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: AppColors.screenBgColor,
                body: const AppListShimmer(),
              ),
        );
      },
    );
  }
}
