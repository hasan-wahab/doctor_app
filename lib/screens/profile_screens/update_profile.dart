import 'dart:io';
import 'dart:math';

import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/local_storage/local_storage.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_api_service/auth_api_services.dart';
import 'package:doctor_app/screens/nave_bar/nave_bar.dart';
import 'package:doctor_app/screens/profile_screens/widgets/profile_appbar.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../app_styles/app_colors.dart';
import '../../widgets/custom_text.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  Map<String, List<String>> data = {};
  bool isLoading = false;
  String? selectedValue;
  DateTime? pickedData;
  @override
  void didChangeDependencies() {
    data =
        ModalRoute.of(context)?.settings.arguments as Map<String, List<String>>;

    super.didChangeDependencies();
  }

  late TextEditingController nameController = TextEditingController(
    text: data['data']?[1],
  );
  late TextEditingController phoneController = TextEditingController(
    text: data['data']?[2],
  );
  late TextEditingController emailController = TextEditingController(
    text: data['data']?[5],
  );
  late TextEditingController cnicController = TextEditingController(
    text: data['data']?[6],
  );

  File? pickImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppbar(title: 'Update profile', isLeading: true),
      backgroundColor: AppColors.bgColor,
      body: isLoading == false
          ? SingleChildScrollView(
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
                          child: Stack(
                            children: [
                              Container(
                                height: 118.h,
                                width: 118.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: 2.h,
                                  ),

                                  shape: BoxShape.circle,
                                ),
                                child: isLoading == false
                                    ? pickImage == null
                                          ? ClipOval(
                                              child: Image.network(
                                                fit: BoxFit.cover,
                                                data['data']?[0] ?? '',
                                                headers: {
                                                  "Authorization":
                                                      "Bearer ${data['data']![7]}",
                                                },
                                              ),
                                            )
                                          : ClipOval(
                                              child: Image.file(
                                                fit: BoxFit.cover,
                                                pickImage!,
                                              ),
                                            )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        ],
                                      ),
                              ),
                              InkWell(
                                onTap: () {
                                  pickImageFromUser();
                                },
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 32.h,
                                    width: 32.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: AppColors.whiteIconColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomText(
                          text: data['data']?[1] ?? "Name",
                          fontSize: 20,
                        ),
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

                            border: Border.all(
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
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

                            border: Border.all(
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                          child: TextFormField(
                            controller: phoneController,

                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
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
                            border: Border.all(
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                          child: DropdownButton<String>(
                            value: data['data']?[3],
                            menuMaxHeight: 100,
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(
                                value: 'Male',
                                child: Text('Male'),
                              ),
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
                            // Original string from your data
                            String dateStr = data['data']![4].isEmpty
                                ? '01/26/2005'
                                : data['data']![4]; // e.g., "01/26/2005"
                            print(dateStr);

                            // Parse the string to DateTime
                            DateFormat format = DateFormat("MM/dd/yyyy");
                            DateTime parsedDate = format.parse(dateStr);
                            // Show date picker
                            showDatePicker(
                              context: context,
                              firstDate: DateTime(
                                1800,
                              ), // Minimum selectable date
                              lastDate: DateTime.now(),
                              initialDate: parsedDate,
                            ).then((pickedDate1) {
                              if (pickedDate1 != null) {
                                pickedData = pickedDate1;
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              DateAndTimeFormater.dateFormat(
                                    pickedData.toString(),
                                  ).isEmpty
                                  ? data['data']![4]
                                  : DateAndTimeFormater.dateFormat(
                                      pickedData.toString(),
                                    ),
                            ),
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

                            border: Border.all(
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    AppButton(
                      text: 'Update',
                      onTap: () async {
                        isLoading = true;
                        setState(() {});
                        final token = await LocalStorage.getUserToken('token');

                        String? name = nameController.text.toString();
                        String? email = emailController.text.toString();
                        String? cnic = cnicController.text.toString();
                        String? phone = phoneController.text.toString();
                        print(cnic);
                        if (name != '' &&
                            email != '' &&
                            cnic != '' &&
                            phone != '') {
                          if (token != null) {
                            if (pickImage != null) {
                              bool iaUpdated =
                                  await AuthApiServices.updateProfileImage(
                                    pickImage!,
                                    token,
                                    context,
                                  );

                              if (iaUpdated == true) {
                                await AuthApiServices.updateApiCall(
                                  name: name,
                                  email: email,
                                  cnic: cnic,
                                  phone: phone,
                                  currentUserToken: token.toString(),
                                ).then((onValue) async {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          NaveBar(currentIndex: 3),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                });
                              }
                            } else {
                              await AuthApiServices.updateApiCall(
                                name: name,
                                email: email,
                                cnic: cnic,
                                phone: phone,
                                currentUserToken: token.toString(),
                              ).then((onValue) async {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        NaveBar(currentIndex: 3),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              });
                            }

                            isLoading = false;
                            setState(() {});
                          } else {
                            print('Token Has Been null');
                          }
                        } else {
                          print('No trigerred');
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  void pickImageFromUser() async {
    setState(() {
      isLoading == true;
    });
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picker != null) {
      final pickedImage = File(picker.path);

      pickImage = pickedImage;
      setState(() {
        isLoading == false;
      });
    }
  }
}
