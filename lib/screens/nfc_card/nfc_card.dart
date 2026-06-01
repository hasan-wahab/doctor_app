// // import 'dart:convert';
// //
// // import 'package:doctor_app/app_styles/app_colors.dart';
// // import 'package:doctor_app/local_storage/local_storage.dart';
// // import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
// // import 'package:doctor_app/screens/nave_bar/nave_bar.dart';
// // import 'package:doctor_app/widgets/custom_text.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:intl/intl.dart';
// //
// // class NfcCard extends StatefulWidget {
// //   const NfcCard({super.key});
// //
// //   @override
// //   State<NfcCard> createState() => _NfcCardState();
// // }
// //
// // class _NfcCardState extends State<NfcCard> {
// //   LoginModel1? profileData;
// //   static const platform = MethodChannel('hce.channel');
// //
// //   void _sendIdToHce(String id) async {
// //     try {
// //       final result = await platform.invokeMethod("setData", {"data": id});
// //       if (result == true) {
// //         if (!mounted) return;
// //         ScaffoldMessenger.of(
// //           context,
// //         ).showSnackBar(const SnackBar(content: Text("ID sent to HCE!")));
// //       }
// //     } on PlatformException catch (e) {
// //       if (!mounted) return;
// //
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(SnackBar(content: Text("Error: ${e.message}")));
// //     }
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     getCurrentUserData();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: AppColors.bgColor,
// //         leading: IconButton(
// //           onPressed: () {
// //             Navigator.pushReplacement(
// //               context,
// //               MaterialPageRoute(builder: (context) => NaveBar()),
// //             );
// //           },
// //           icon: Icon(Icons.arrow_back_ios_new),
// //         ),
// //         centerTitle: true,
// //         title: Text('My Card'),
// //         automaticallyImplyLeading: false,
// //       ),
// //       backgroundColor: AppColors.bgColor,
// //
// //       body: profileData != null
// //           ? SingleChildScrollView(
// //               padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
// //               child: profileData!.patientData!.patientInfo!.cardUid != null
// //                   ? Column(
// //                       crossAxisAlignment: CrossAxisAlignment.stretch,
// //                       children: [
// //                         Container(
// //                           height: 260.h,
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(15.0),
// //                             gradient: const LinearGradient(
// //                               colors: [Colors.red, Colors.amber],
// //                               begin: Alignment.topLeft,
// //                               end: Alignment.bottomRight,
// //                             ),
// //                             boxShadow: [
// //                               BoxShadow(
// //                                 color: Colors.black26,
// //                                 blurRadius: 10,
// //                                 offset: Offset(0, 5),
// //                               ),
// //                             ],
// //                           ),
// //                           child: Padding(
// //                             padding: EdgeInsets.symmetric(
// //                               horizontal: 15.w,
// //                               vertical: 10.h,
// //                             ),
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Column(
// //                                       crossAxisAlignment:
// //                                           CrossAxisAlignment.start,
// //                                       children: [
// //                                         const CustomText(
// //                                           text: "ALI THERAPY",
// //                                           fontSize: 18,
// //                                           color: Colors.yellow,
// //                                         ),
// //                                         SizedBox(height: 15.h),
// //                                         Row(
// //                                           mainAxisAlignment:
// //                                               MainAxisAlignment.start,
// //                                           spacing: 10.w,
// //                                           children: [
// //                                             Container(
// //                                               height: 50.h,
// //                                               width: 50.w,
// //                                               decoration: BoxDecoration(
// //                                                 color: Colors.white,
// //                                                 borderRadius:
// //                                                     BorderRadius.circular(12.r),
// //                                                 image: DecorationImage(
// //                                                   fit: BoxFit.cover,
// //                                                   image: NetworkImage(
// //                                                     profileData!
// //                                                             .patientData!
// //                                                             .patientInfo!
// //                                                             .image
// //                                                             .toString()
// //                                                             .isNotEmpty
// //                                                         ? profileData!
// //                                                               .patientData!
// //                                                               .patientInfo!
// //                                                               .image
// //                                                               .toString()
// //                                                         : "No data",
// //                                                   ),
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                             Column(
// //                                               crossAxisAlignment:
// //                                                   CrossAxisAlignment.start,
// //                                               children: [
// //                                                 CustomText(
// //                                                   text: profileData!.user!.name
// //                                                       .toString(),
// //                                                   fontSize: 18,
// //                                                   color:
// //                                                       AppColors.secondaryColor,
// //                                                   fontWeight: FontWeight.bold,
// //                                                 ),
// //                                                 CustomText(
// //                                                   text:
// //                                                       profileData!
// //                                                               .patientData!
// //                                                               .patientInfo!
// //                                                               .cardUid
// //                                                               .toString() ==
// //                                                           null.toString()
// //                                                       ? 'No data'
// //                                                       : profileData!
// //                                                             .patientData!
// //                                                             .patientInfo!
// //                                                             .cardUid
// //                                                             .toString(),
// //                                                   fontSize: 15,
// //                                                   color:
// //                                                       AppColors.textWhiteColor,
// //                                                 ),
// //                                               ],
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ],
// //                                     ),
// //                                     Container(
// //                                       padding: EdgeInsets.all(5),
// //                                       height: 70.h,
// //                                       width: 80,
// //                                       decoration: BoxDecoration(
// //                                         color: Colors.white,
// //                                         borderRadius: BorderRadius.circular(
// //                                           12.r,
// //                                         ),
// //                                         boxShadow: [
// //                                           BoxShadow(
// //                                             color: Colors.black12,
// //                                             blurRadius: 10,
// //                                             spreadRadius: 1,
// //                                             offset: Offset(0, 4),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                       child: Image.asset(
// //                                         'assets/images/main_logo.png',
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 SizedBox(height: 8.h),
// //                                 SizedBox(
// //                                   width: MediaQuery.sizeOf(context).width / 2,
// //                                   child: Column(
// //                                     children: [
// //                                       Row(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceBetween,
// //                                         children: [
// //                                           CustomText(
// //                                             text: 'Phone',
// //                                             color: AppColors.textWhiteColor,
// //                                             fontSize: 13,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                           CustomText(
// //                                             text:
// //                                                 profileData!
// //                                                     .patientData!
// //                                                     .patientInfo!
// //                                                     .phone
// //                                                     .toString()
// //                                                     .isNotEmpty
// //                                                 ? profileData!
// //                                                       .patientData!
// //                                                       .patientInfo!
// //                                                       .phone
// //                                                       .toString()
// //                                                 : 'No data',
// //                                             color: AppColors.textWhiteColor,
// //                                             fontSize: 13,
// //                                           ),
// //                                         ],
// //                                       ),
// //                                       Row(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceBetween,
// //                                         children: [
// //                                           CustomText(
// //                                             text: 'CNIC',
// //                                             color: AppColors.textWhiteColor,
// //                                             fontSize: 13,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                           CustomText(
// //                                             text:
// //                                                 profileData!
// //                                                     .patientData!
// //                                                     .patientInfo!
// //                                                     .cnic
// //                                                     .toString()
// //                                                     .isNotEmpty
// //                                                 ? profileData!
// //                                                       .patientData!
// //                                                       .patientInfo!
// //                                                       .cnic
// //                                                       .toString()
// //                                                 : 'No data',
// //                                             color: AppColors.textWhiteColor,
// //                                             fontSize: 13,
// //                                           ),
// //                                         ],
// //                                       ),
// //                                       Row(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceBetween,
// //                                         children: [
// //                                           CustomText(
// //                                             text: 'Blood',
// //                                             color: AppColors.textWhiteColor,
// //                                             fontSize: 13,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                           CustomText(
// //                                             text:
// //                                                 profileData!
// //                                                     .patientData!
// //                                                     .patientInfo!
// //                                                     .bloodGroup
// //                                                     .toString()
// //                                                     .isNotEmpty
// //                                                 ? profileData!
// //                                                       .patientData!
// //                                                       .patientInfo!
// //                                                       .bloodGroup
// //                                                       .toString()
// //                                                 : 'No data',
// //                                             color: AppColors.textWhiteColor,
// //                                             fontSize: 13,
// //                                           ),
// //                                         ],
// //                                       ),
// //                                       Row(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceBetween,
// //                                         children: [
// //                                           CustomText(
// //                                             text: 'Gender',
// //                                             color: AppColors.textWhiteColor,
// //                                             fontSize: 13,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                           CustomText(
// //                                             text:
// //                                                 profileData!
// //                                                     .patientData!
// //                                                     .patientInfo!
// //                                                     .gender
// //                                                     .toString()
// //                                                     .isNotEmpty
// //                                                 ? profileData!
// //                                                       .patientData!
// //                                                       .patientInfo!
// //                                                       .gender
// //                                                       .toString()
// //                                                 : 'No data',
// //                                             color: AppColors.textWhiteColor,
// //                                             fontSize: 13,
// //                                           ),
// //                                         ],
// //                                       ),
// //                                       Row(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceBetween,
// //                                         children: [
// //                                           CustomText(
// //                                             text: 'Date',
// //                                             color: AppColors.textWhiteColor,
// //                                             fontSize: 13,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //
// //                                           profileData!
// //                                                       .patientData!
// //                                                       .patientInfo
// //                                                       ?.birthDate
// //                                                       .toString() ==
// //                                                   null
// //                                               ? CustomText(
// //                                                   text: DateFormat("dd-MM-yyyy")
// //                                                       .format(
// //                                                         DateTime.parse(
// //                                                           profileData!
// //                                                               .patientData!
// //                                                               .patientInfo!
// //                                                               .birthDate,
// //                                                         ),
// //                                                       ),
// //                                                   color:
// //                                                       AppColors.textWhiteColor,
// //                                                   fontSize: 13,
// //                                                 )
// //                                               : CustomText(
// //                                                   text: 'No data',
// //                                                   color:
// //                                                       AppColors.textWhiteColor,
// //                                                 ),
// //                                         ],
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 8.h),
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     Column(
// //                                       crossAxisAlignment:
// //                                           CrossAxisAlignment.start,
// //                                       children: [
// //                                         CustomText(
// //                                           text:
// //                                               'Main Boulevard, Gulberg III, Lahore',
// //                                           fontSize: 12,
// //                                           color: AppColors.secondaryTextColor,
// //                                         ),
// //                                         CustomText(
// //                                           text:
// //                                               '+92 42 3578 5555 | +92 300 1234567',
// //                                           fontSize: 12,
// //                                           color: AppColors.secondaryTextColor,
// //                                         ),
// //                                       ],
// //                                     ),
// //                                     Icon(
// //                                       Icons.wifi,
// //                                       color: AppColors.whiteIconColor,
// //                                       size: 40.r,
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //
// //                         const SizedBox(height: 30),
// //
// //                         const Center(
// //                           child: Text(
// //                             "Hold phone close to the NFC reader",
// //                             style: TextStyle(color: Colors.black87),
// //                           ),
// //                         ),
// //                       ],
// //                     )
// //                   : Center(child: Text('No Card Available')),
// //             )
// //           : Center(child: CircularProgressIndicator()),
// //     );
// //   }
// //
// //   void getCurrentUserData() async {
// //     String? token = await LocalStorage.getUserToken('token');
// //     if (token != null) {
// //       String? data = await LocalStorage.getProfileData(token);
// //
// //       final jsonData = jsonDecode(data!);
// //       profileData = LoginModel1.fromJson(jsonData);
// //       if (profileData!.patientData!.patientInfo!.cardUid != null) {
// //         _sendIdToHce(profileData!.patientData!.patientInfo!.cardUid.toString());
// //         print(profileData!.patientData!.patientInfo!.image.toString());
// //       }
// //
// //       setState(() {});
// //     } else {
// //       print('profile data nul //////////');
// //     }
// //   }
// // }
//

import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:doctor_app/screens/nfc_card/bloc/nfc_card_bloc.dart';
import 'package:doctor_app/screens/nfc_card/bloc/nfc_card_event.dart';
import 'package:doctor_app/screens/nfc_card/bloc/nfc_card_state.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show AppBar, AssetImage, Border, BorderRadius, BorderSide, BoxDecoration, BoxFit, BuildContext, Center, Color, Colors, Column, Container, CrossAxisAlignment, DecorationImage, EdgeInsets, Expanded, FontWeight, Icon, IconButton, Icons, Image, ListView, MainAxisAlignment, Navigator, Radius, Row, Scaffold, SizedBox, State, StatefulWidget, TargetPlatform, Text, TextStyle, Widget, WillPopScope, debugPrint;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../nave_bar/nave_bar.dart';

class NfcCardPage extends StatefulWidget {
  bool fromProfile;
  NfcCardPage({super.key, this.fromProfile = false});

  @override
  State<NfcCardPage> createState() => _NfcCardPageState();
}

class _NfcCardPageState extends State<NfcCardPage> {
  PatientModel? patientModel;
  bool isLoading = false;

  static const MethodChannel _hceChannel = MethodChannel('hce.channel');

  /// Android [MainActivity] par `setData` — [MyHostApduService.virtualData] update hota hai.
  Future<void> _pushCardUidToHce(String cardUid) async {
    if (defaultTargetPlatform != TargetPlatform.android) return;
    if (cardUid.isEmpty) return;
    try {
      await _hceChannel.invokeMethod<bool>('setData', <String, dynamic>{
        'data': cardUid,
      });
    } catch (e, st) {
      debugPrint('HCE setData failed: $e\n$st');
    }
  }

  @override
  void initState() {
    context.read<NfcCardBloc>().add(NfcCardEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.fromProfile == false) {
          context.read<NaveBarBloc>().add(NaveBarIndexEvent(index: 0));
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: BlocConsumer<NfcCardBloc, NfcCardState>(
        listener: (context, state) {
          if (state is NfcLoadingState) {
            isLoading = true;
          }
          if (state is NfcMessageState) {
            AppMsg.showSnackBar(context, message: state.message.toString());
          }
          if (state is NfcCardDataState) {
            patientModel = state.patientModel;
            final uid = patientModel?.cardUid;
            if (uid != null && uid.isNotEmpty) {
              _pushCardUidToHce(uid);
            }
          }
        },
        builder: (context, state) {
          if (patientModel != null) {
            if (patientModel!.cardUid != null && patientModel!.cardUid != '') {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.bgColor,
                  leading: IconButton(
                    onPressed: () {
                      if (widget.fromProfile == false) {
                        context.read<NaveBarBloc>().add(
                          NaveBarIndexEvent(index: 0),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  centerTitle: true,
                  title: Text('My Card'),
                  automaticallyImplyLeading: false,
                ),
                body: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 15.h,
                  ),
                  children: [
                    /// CARD
                    Container(
                      height: 220.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Color(0xFF167FC9),
                      ),

                      child: Column(
                        children: [
                          /// Top
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            height: 72.h,
                            decoration: BoxDecoration(
                              color: Color(0xFF167FC9),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.r),
                                topRight: Radius.circular(12.r),
                              ),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 0.3,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'DR. ALI THARAPY',
                                      style: TextStyle(
                                        color: AppColors.textWhiteColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.w,
                                      ),
                                    ),
                                    CustomText(
                                      text: 'PATIENT IDENTIFICATION CARD',
                                      style: TextStyle(
                                        color: AppColors.textWhiteColor,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.w,
                                      ),
                                    ),
                                    CustomText(
                                      text:
                                          'Pakland & Kiran Plaza F-8, Islamabad, Islamabad',
                                      style: TextStyle(
                                        color: AppColors.textWhiteColor,
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.h,
                                    // vertical: 8.h,
                                  ),
                                  height: 45.h,
                                  width: 45.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Image.asset(
                                    'assets/images/main_logo.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Middle
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              child: Row(
                                spacing: 16.w,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4.r),
                                        height: 52.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.w,
                                            color: AppColors.whiteIconColor,
                                          ),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child:
                                            patientModel!.displayImageUrl !=
                                                'No data'
                                            ? Image.network(
                                                patientModel!.displayImageUrl,
                                              )
                                            : Icon(
                                                Icons.image,
                                                color: Colors.grey,
                                              ),
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 30.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.w,
                                            color: AppColors.whiteIconColor,
                                          ),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/sim_chip.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: patientModel!.displayName,
                                        style: TextStyle(
                                          color: AppColors.textWhiteColor,
                                          letterSpacing: 1.w,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      CustomText(
                                        text:
                                            'ID  ${patientModel!.cardUid ?? "569EF532"}',
                                        style: TextStyle(
                                          color: AppColors.textWhiteColor,
                                          letterSpacing: 1.w,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      SizedBox(
                                        width: 170.w,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: CustomText(
                                                text: 'PHONE',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textWhiteColor,
                                                  letterSpacing: 1.w,
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: CustomText(
                                                text: ':',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textWhiteColor,
                                                  letterSpacing: 1.w,
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: CustomText(
                                                text:
                                                    patientModel!.displayPhone,
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textWhiteColor,
                                                  letterSpacing: 1.w,
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        width: 170.w,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: CustomText(
                                                text: 'CNIC',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textWhiteColor,
                                                  letterSpacing: 1.w,
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: CustomText(
                                                text: ':',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textWhiteColor,
                                                  letterSpacing: 1.w,
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: CustomText(
                                                text: patientModel!.displayCnic,
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textWhiteColor,
                                                  letterSpacing: 1.w,
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 170.w,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: CustomText(
                                                text: 'BLOOD',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textWhiteColor,
                                                  letterSpacing: 1.w,
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: CustomText(
                                                text: ':',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textWhiteColor,
                                                  letterSpacing: 1.w,
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: CustomText(
                                                text: patientModel!
                                                    .displayBloodGroup,
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textWhiteColor,
                                                  letterSpacing: 1.w,
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// Bottom
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 6.h,
                            ),
                            height: 38.h,
                            decoration: BoxDecoration(
                              color: Color(0xFF167FC9),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12.r),
                                bottomRight: Radius.circular(12.r),
                              ),
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 0.3,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'https://alitherapy.neonweb.tech/',
                                      style: TextStyle(
                                        color: AppColors.textWhiteColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8.sp,
                                        letterSpacing: 1.w,
                                      ),
                                    ),
                                    CustomText(
                                      text: '0516125380',
                                      style: TextStyle(
                                        color: AppColors.textWhiteColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8.sp,
                                        letterSpacing: 1.w,
                                      ),
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text: '0000000000013933',
                                  style: TextStyle(
                                    color: AppColors.textWhiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 8.sp,
                                    letterSpacing: 1.w,
                                  ),
                                ),
                                Container(
                                  height: 25.h,
                                  width: 25.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteIconColor,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Icon(Icons.qr_code),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hold phone close to the NFC reader",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.bgColor,
                  leading: IconButton(
                    onPressed: () {
                      if (widget.fromProfile == false) {
                        context.read<NaveBarBloc>().add(
                          NaveBarIndexEvent(index: 0),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  centerTitle: true,
                  title: Text('My Card'),
                  automaticallyImplyLeading: false,
                ),
                body: Center(child: CustomText(text: 'Card Not Available!')),
              );
            }
          } else {
            return Scaffold(
              body: Center(child: CustomText(text: 'No Data')),
            );
          }
        },
      ),
    );
  }
}
