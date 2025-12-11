import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../local_storage/local_storage.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/outline_button.dart';

class PackagesWidget extends StatefulWidget {
  List<String> imageList;
  List<String> textList;
  PackagesWidget({super.key, required this.imageList, required this.textList});

  @override
  State<PackagesWidget> createState() => _PackagesWidgetState();
}

class _PackagesWidgetState extends State<PackagesWidget> {
  String? token;

  @override
  void initState() {
    getTokenValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      width: 351.w,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 15.w,
          children: List.generate((6), (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    image: DecorationImage(
                      image: AssetImage(widget.imageList[index]),
                    ),
                  ),
                ),
                CustomText(text: widget.textList[index], fontSize: 12),
                AppOutlineButton(
                  onTap: () {
                    if (token == null) {
                      Navigator.pushNamed(context, AppRoutes.loginScreen);
                    }
                  },
                  text: 'Book',
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  void getTokenValue() async {
    token = await LocalStorage.getUserToken('token');
  }
}
