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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../nave_bar/nave_bar.dart';

class NfcCardPage extends StatelessWidget {
  const NfcCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NaveBar()),
              );
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          centerTitle: true,
          title: Text('My Card'),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          children: [
            /// CARD
            Container(
              height: 220.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                gradient: LinearGradient(
                  colors: [
                    Colors.primaries[4],
                    Colors.primaries[4],
                    Colors.blueAccent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.03,
                      right: screenWidth * 0.03,
                      top: screenWidth * 0.03,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Left info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ALI THERAPY",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenWidth * 0.02),
                            Row(
                              spacing: 10.w,
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.h,
                                  padding: EdgeInsets.all(screenWidth * 0.2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.02,
                                    ),
                                  ),
                                  child: Image.asset(
                                    'assets/images/circle_avatar.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Column(
                                  spacing: 4.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "MUHAMMAD MAZHAR ALI",
                                      style: TextStyle(
                                        color: AppColors.whiteIconColor,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      "C2199B03",
                                      style: TextStyle(
                                        color: AppColors.whiteIconColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        const Spacer(),

                        /// Logo
                        Container(
                          height: 50.h,
                          width: 50.h,
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Image.asset(
                            "assets/logo.png", // apna logo path
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// DETAILS
                  Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: _row("Phone", "0324-8511223", screenWidth),
                        ),
                        Expanded(
                          child: _row("CNIC", "17101-7897602-4", screenWidth),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    child: Row(
                      children: [
                        Expanded(child: _row("Blood", "B+", screenWidth)),
                        Expanded(child: _row("Gender", "Male", screenWidth)),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    child: _row("Date", "No data", screenWidth),
                  ),

                  const Spacer(),

                  /// FOOTER
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 30.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.w, right: 15.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pakland & Kiran Plaza, near IDC, F-Islamabad, 48000(051) 2125380',
                                  style: TextStyle(
                                    letterSpacing: 0.15.w,
                                    color: Colors.white,
                                    fontSize: 9.sp,
                                  ),
                                ),
                                Icon(
                                  Icons.wifi,
                                  color: AppColors.whiteIconColor,
                                  size: 12.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
                  style: TextStyle(color: Colors.black54, fontSize: 18.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: width * 0.02,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.whiteIconColor, fontSize: 13.sp),
          ),

          Text(
            value,
            style: TextStyle(
              color: AppColors.whiteIconColor,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
