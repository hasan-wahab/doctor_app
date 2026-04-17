import 'package:doctor_app/data/api_service/base_api/base_api_impl.dart';
import 'package:doctor_app/data/local_storage/local_storage.dart';
import 'package:doctor_app/repos/api_repo/auth_repo.dart';
import 'package:doctor_app/repos/api_repo/auth_repo_base.dart';
import 'package:doctor_app/screens/auth_screen/bloc/login_bloc.dart';
import 'package:doctor_app/screens/nfc_card/nfc_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app_routes/generate_route.dart';

Future<void> main() async {
  runApp(const MyApp());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//await LocalStorage.clearAllData();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    AuthRepoBase authRepoBase = AuthRepoImpl(api: BaseApiImpl());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(authRepo: authRepoBase)),
      ],
      child: ScreenUtilInit(
        designSize: Size(390, 844),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          onGenerateRoute: (RouteSettings settings) {
            return AppGenerateRoute.onGenerateRoute(settings, context);
          },
        ),
      ),
    );
  }
}
