import 'package:doctor_app/app_routes/generate_route.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/login_screen.dart';
import 'package:doctor_app/screens/home/home_screen.dart';
import 'package:doctor_app/screens/nave_bar.dart';
import 'package:doctor_app/screens/splash_scree/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        //home:  LoginScreen(),
        onGenerateRoute: (RouteSettings settings) {
          return AppGenerateRoute.onGenerateRoute(settings, context);
        },
      ),
    );
  }
}
