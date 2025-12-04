import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NfcCard extends StatefulWidget {
  const NfcCard({super.key});

  @override
  State<NfcCard> createState() => _NfcCardState();
}

class _NfcCardState extends State<NfcCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Card'),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
      ),
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 260.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.amber,],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(text: "ALI THERAPY",fontSize: 18,color: Colors.yellow,),
                            SizedBox(height: 15.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              spacing: 10.w,
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/images/profile_image.png'))
                                  ),
                                ),
                                Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(text: 'Hasan wahab',fontSize: 18,color: AppColors.secondaryColor,fontWeight: FontWeight.bold,),
                                    CustomText(text: '1234567',fontSize: 15,color: AppColors.textWhiteColor,),

                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 70.h,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: Offset(0, 4)
                              )
                            ]
                          ),
                          child:Image.asset('assets/images/main_logo.png'),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h,),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width/2,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'Phone',color: AppColors.textWhiteColor,fontSize: 13,fontWeight: FontWeight.bold,),
                              CustomText(text: '0987654321',color: AppColors.textWhiteColor,fontSize: 13,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'CNIC',color: AppColors.textWhiteColor,fontSize: 13,fontWeight: FontWeight.bold,),
                              CustomText(text: '0987654321',color: AppColors.textWhiteColor,fontSize: 13,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'Blood',color: AppColors.textWhiteColor,fontSize: 13,fontWeight: FontWeight.bold,),
                              CustomText(text: 'O+',color: AppColors.textWhiteColor,fontSize: 13,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'Gender',color: AppColors.textWhiteColor,fontSize: 13,fontWeight: FontWeight.bold,),
                              CustomText(text: 'Male',color: AppColors.textWhiteColor,fontSize: 13,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: 'Issued',color: AppColors.textWhiteColor,fontSize: 13,fontWeight: FontWeight.bold,),
                              CustomText(text: ' 03-Dec-25',color: AppColors.textWhiteColor,fontSize: 13,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: 'Main Boulevard, Gulberg III, Lahore',fontSize: 12,color: AppColors.secondaryTextColor,),
                            CustomText(text: '+92 42 3578 5555 | +92 300 1234567',fontSize: 12,color: AppColors.secondaryTextColor,),
                          ],
                        ),
                        Icon(Icons.wifi,color: AppColors.whiteIconColor,size: 40.r,),
                      ],
                    )




                  ],
                ),
              ),
            ),


            const SizedBox(height: 30),


            const Center(
              child: Text(
                "Hold phone close to the NFC reader",
                style: TextStyle(color: Colors.black87),
              ),
            )
          ],
        ),
      ),
    );
  }
}
