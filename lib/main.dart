import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api_impl.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/local_storage/local_storage.dart';
import 'package:doctor_app/repos/auth_repo/auth_repo.dart';
import 'package:doctor_app/repos/patient_local_repo/patient_local_repo.dart';
import 'package:doctor_app/repos/patient_repo/patient_repo_impl.dart';

import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/auth_screen/bloc/login_bloc.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nfc_card/nfc_card.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app_routes/generate_route.dart';
import 'data/api_service/base_api/base_api.dart';
import 'data/local_storage/local_curd_base/local_curd_impl.dart';
import 'repos/auth_repo/auth_repo_base.dart';

Future<void> main() async {
  runApp(const MyApp());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await LocalStorage.clearAllData();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BaseApiImpl apiImpl;
  late LocalCurdImpl curdImpl;
  late ProfileLocalRepo profileLocalRepo;
  late PatientLocalRepo patientLocalRepo;
  late PatientRepoImpl patientRepoImpl;
  late AuthRepoBase authRepoBase;
  @override
  void initState() {
    super.initState();

    apiImpl = BaseApiImpl();
    curdImpl = LocalCurdImpl();

    profileLocalRepo = ProfileLocalRepo(curdBase: curdImpl);

    patientLocalRepo = PatientLocalRepo(curdBase: curdImpl);

    patientRepoImpl = PatientRepoImpl(
      api: apiImpl,
      profileLocalRepo: profileLocalRepo,
      curdBase: curdImpl,
      patientLocalRepo: patientLocalRepo,
    );

    authRepoBase = AuthRepoImpl(
      patientLocalRepo: patientLocalRepo,
      api: apiImpl,
      localRepo: profileLocalRepo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            authRepo: authRepoBase,
            profileLocalRepo: profileLocalRepo,
          ),
        ),
        BlocProvider(
          create: (context) => NaveBarBloc(profileLocalRepo: profileLocalRepo),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            profileLocalRepo: profileLocalRepo,
            patientLocalRepo: patientLocalRepo,
          ),
        ),
        BlocProvider(
          create: (context) => DashboardBloc(
            profileLocalRepo: profileLocalRepo,
            patientRepoBase: patientRepoImpl,
            patientLocalRepo: patientLocalRepo,
          ),
        ),
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
