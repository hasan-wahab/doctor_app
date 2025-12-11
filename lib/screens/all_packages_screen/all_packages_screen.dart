import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/local_storage/local_storage.dart';
import 'package:doctor_app/screens/all_packages_screen/package_model.dart';
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
  List<PackageModel> result = [];
  final List<PackageModel> therapyName = [
    PackageModel(
      name: 'Lumber Spine',
      imageUrl: 'assets/images/lumber_spine.jpg',
    ),
    PackageModel(
      name: 'Neck spine',
      imageUrl:
          'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_09398bb8.jpg',
    ),
    PackageModel(
      name: 'Knee',
      imageUrl:
          'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_b67304dd.jpg',
    ),
    PackageModel(
      name: 'Shoulder',
      imageUrl:
          'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_fa78fbd2.jpg',
    ),
    PackageModel(
      name: 'Ankle',
      imageUrl:
          'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_161d70ba.jpg',
    ),
    PackageModel(
      name: 'Hip',
      imageUrl:
          'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_a2ce2777.jpg',
    ),
    PackageModel(
      name: 'Lumber Spine',
      imageUrl: 'assets/images/lumber_spine.jpg',
    ),
    PackageModel(
      name: 'Neck spine',
      imageUrl:
          'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_09398bb8.jpg',
    ),
    PackageModel(
      name: 'Knee',
      imageUrl:
          'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_b67304dd.jpg',
    ),
    PackageModel(
      name: 'Shoulder',
      imageUrl:
          'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_fa78fbd2.jpg',
    ),
    PackageModel(
      name: 'Ankle',
      imageUrl:
          'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_161d70ba.jpg',
    ),
    PackageModel(
      name: 'Hip',
      imageUrl:
          'assets/images/WhatsApp Image 2025-11-20 at 17.41.20_a2ce2777.jpg',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AllPackagesAppbar(
        onChanged: (value) {
          final searchResult = therapyName.where((element) {
            final test = element.name.toLowerCase();
            return test.contains(value!.toLowerCase());
          });
          result = searchResult.toList();
          setState(() {});
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 36.h, left: 20.w, right: 20.w),
        child: GridView.builder(
          itemCount: result.isEmpty ? therapyName.length : result.length,
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
                      image: AssetImage(
                        result.isEmpty
                            ? therapyName[index].imageUrl
                            : result[index].imageUrl,
                      ),
                    ),
                  ),
                ),
                CustomText(
                  text: result.isEmpty
                      ? therapyName[index].name
                      : result[index].name,
                  fontSize: 12,
                ),
                AppOutlineButton(
                  onTap: () async {
                    final user = await LocalStorage.getUserToken('token');
                    if (user == null) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.loginScreen,
                      );
                    }
                  },
                  text: 'Book',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
