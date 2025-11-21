import 'package:doctor_app/screens/all_packages_screen/widgets/all_packages_appbar.dart';
import 'package:doctor_app/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_text.dart';
import '../../widgets/outline_button.dart';
import '../home/home_widget/packages_widget.dart' show PackagesWidget;

class AllPackagesScreen extends StatefulWidget {
  const AllPackagesScreen({super.key});

  @override
  State<AllPackagesScreen> createState() => _AllPackagesScreenState();
}

class _AllPackagesScreenState extends State<AllPackagesScreen> {
  List<String> therapyName = [
    'Lumber Spine',
    'Neck spine',
    'Knee',
    'Shoulder',
    'Ankle',
    'Hip',
    'Lumber Spine',
    'Neck spine',
    'Knee',
    'Knee',
    'Shoulder',
    'Ankle',
    'Hip',
  ];
  List<String> therapyImages = [
    'assets/images/lumber_spine.jpg',
    'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_09398bb8.jpg',
    'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_b67304dd.jpg',
    'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_fa78fbd2.jpg',
    'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_161d70ba.jpg',
    'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_a2ce2777.jpg',
    'assets/images/lumber_spine.jpg',
    'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_09398bb8.jpg',
    'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_b67304dd.jpg',
    'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_fa78fbd2.jpg',
    'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_fa78fbd2.jpg',
    'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_161d70ba.jpg',
    'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_a2ce2777.jpg',
    'assets/images/lumber_spine.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AllPackagesAppbar(),
      body: Padding(
        padding: EdgeInsets.only(top: 36.h, left: 20.w, right: 20.w),
        child: GridView.builder(
          itemCount: therapyName.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 150.h,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.w,
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),

                    image: DecorationImage(
                      image: AssetImage(therapyImages[index]),
                    ),
                  ),
                ),
                CustomText(text: therapyName[index], fontSize: 12),
                AppOutlineButton(onTap: () {}, text: 'Book'),
              ],
            );
          },
        ),
      ),
    );
  }
}
