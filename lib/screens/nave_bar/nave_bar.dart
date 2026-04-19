import 'dart:io';

import 'package:doctor_app/screens/auth_screen/login_screen/login_screen.dart';
import 'package:doctor_app/screens/dashboard_screen/dashbord_screen.dart';
import 'package:doctor_app/screens/home/home_screen.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:doctor_app/screens/nfc_card/nfc_card.dart';
import 'package:doctor_app/screens/profile_screens/profile_screen.dart';
import 'package:doctor_app/screens/session_record/session_record.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/foundation.dart';
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
  String? token;
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
    context.read<NaveBarBloc>().add(NaveBarEvent(index: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NaveBarBloc, NaveBarState>(
      builder: (context, state) {
        return Scaffold(
          body: state.token == null
              ? screenList.elementAt(state.index)
              : screenList2.elementAt(state.index),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
            height: Platform.isIOS ? 701.h : 100.h,
            color: AppColors.secondaryColor,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate((iconText.length), (index) {
                  return InkWell(
                    onTap: () {
                      if (state.token == null) {
                        context.read<NaveBarBloc>().add(
                          NaveBarEvent(index: index == 0 ? index : 3),
                        );
                      } else {
                        context.read<NaveBarBloc>().add(
                          NaveBarEvent(index: index),
                        );
                      }
                    },

                    child: Column(
                      children: [
                        Icon(
                          icons[index],
                          color: state.index == index
                              ? AppColors.primaryColor
                              : AppColors.blackIconColor,
                        ),
                        CustomText(
                          text: iconText[index],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: state.index == index
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
        );
      },
    );
  }
}
