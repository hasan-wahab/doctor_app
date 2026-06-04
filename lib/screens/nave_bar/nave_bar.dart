import 'dart:io';

import 'package:doctor_app/screens/auth_screen/login_screen/login_screen.dart';
import 'package:doctor_app/screens/dashboard_screen/dashbord_screen.dart';
import 'package:doctor_app/screens/home/home_screen.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:doctor_app/screens/nfc_card/nfc_card.dart';
import 'package:doctor_app/screens/profile_screens/profile_screen.dart';
import 'package:doctor_app/screens/session_record/session_record.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/local_storage/local_storage.dart';
import 'bloc/nave_bar_state.dart';

class NaveBar extends StatefulWidget {
  NaveBar({super.key});

  @override
  State<NaveBar> createState() => _NaveBarState();
}

class _NaveBarState extends State<NaveBar> {
  final List<String> iconText = ['Home', 'My card', 'Records', 'Account'];
  final List<IconData> icons = [
    Icons.home,
    Icons.credit_card,
    Icons.list_alt_rounded,
    Icons.person_2_outlined,
  ];
  List<Widget> screenList = [
    HomeScreen(),
    NfcCardPage(),
    SessionRecord(),
    LoginScreen(),
  ];
  List<Widget> screenList2 = [
    DashbordScreen(),
    NfcCardPage(),
    SessionRecord(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    context.read<NaveBarBloc>().add(NaveBarIndexEvent(index: 0));
    super.initState();
  }

  bool isLoading = false;
  int currentIndex = 0;
  String? token = '';
  @override
  Widget build(BuildContext context) {
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
        }
      },
      builder: (context, state) {
        return isLoading == false
            ? Scaffold(
                body: token == ''
                    ? screenList.elementAt(currentIndex)
                    : screenList2.elementAt(currentIndex),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
                  height: Platform.isIOS ? 701.h : 100.h,
                  color: AppColors.secondaryColor,
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate((iconText.length), (index) {
                          return InkWell(
                            onTap: () {
                              if (token == '') {
                                context.read<NaveBarBloc>().add(
                                  NaveBarIndexEvent(
                                    index: index == 0 ? index : 3,
                                  ),
                                );
                              } else {
                                context.read<NaveBarBloc>().add(
                                  NaveBarIndexEvent(index: index),
                                );
                              }
                            },

                            child: Column(
                              children: [
                                Icon(
                                  icons[index],
                                  color: currentIndex == index
                                      ? AppColors.primaryColor
                                      : AppColors.blackIconColor,
                                ),
                                CustomText(
                                  text: iconText[index],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: currentIndex == index
                                      ? AppColors.primaryColor
                                      : AppColors.blackIconColor,
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              )
            : Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
