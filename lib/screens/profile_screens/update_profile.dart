import 'package:doctor_app/screens/profile_screens/widgets/profile_appbar.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_styles/app_colors.dart';
import '../../widgets/custom_text.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  Map<String, List<String>> data = {};
  String? selectedValue;
  @override
  void didChangeDependencies() {
    data =
        ModalRoute.of(context)?.settings.arguments as Map<String, List<String>>;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppbar(title: 'Update profile', isLeading: true),
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            spacing: 10.h,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 120.h,
                    width: 120.w,
                    child: Container(
                      height: 118.h,
                      width: 118.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data['data']?[0]??''),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  CustomText(text: data['data']?[1] ?? "Name", fontSize: 20),
                  CustomText(
                    text: 'Patient ID: #MC-2025',
                    color: AppColors.secondaryTextColor,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Name'),
                  Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),

                      border: Border.all(color: AppColors.secondaryTextColor),
                    ),
                    child: TextFormField(
                      initialValue: data['data']?[1],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Phone'),
                  Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),

                      border: Border.all(color: AppColors.secondaryTextColor),
                    ),
                    child: TextFormField(
                      initialValue: data['data']?[2],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Gender'),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    width: MediaQuery.sizeOf(context).width,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.secondaryTextColor),
                    ),
                    child: DropdownButton<String>(
                      value: data['data']?[3],
                      menuMaxHeight: 100,
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                        DropdownMenuItem(
                          value: ' Female',
                          child: Text('Female'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          data['data']![2] = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'DOB'),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime(1800),
                        lastDate: DateTime.now(),
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      height: 50.h,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),

                        border: Border.all(color: AppColors.secondaryTextColor),
                      ),
                      child: Text(data['data']![4]),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Email'),
                  Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),

                      border: Border.all(color: AppColors.secondaryTextColor),
                    ),
                    child: TextFormField(
                      initialValue: data['data']![5],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              AppButton(text: 'Update'),
            ],
          ),
        ),
      ),
    );
  }
}
