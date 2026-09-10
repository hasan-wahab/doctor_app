import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api_impl.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/local_storage/local_storage.dart';
import 'package:doctor_app/repos/all_consultant_assessment_repo/all_consultant_assessmant_local_repo.dart';
import 'package:doctor_app/repos/all_consultant_assessment_repo/all_consultant_assessmant_repo.dart';
import 'package:doctor_app/repos/all_packages_repo/all_packages_local_repo.dart';
import 'package:doctor_app/repos/all_packages_repo/all_packages_repo.dart';
import 'package:doctor_app/repos/all_therapy_session_repo/all_therapy_session_local_repo.dart';
import 'package:doctor_app/repos/all_therapy_session_repo/all_therapy_session_repo.dart';
import 'package:doctor_app/repos/all_visits_repo/all_visits_local_repo.dart';
import 'package:doctor_app/repos/all_visits_repo/all_visits_repo.dart';
import 'package:doctor_app/repos/auth_repo/auth_repo.dart';
import 'package:doctor_app/repos/consultant_assasment_repo/consultant_assesment_repo.dart';
import 'package:doctor_app/repos/history_tracker_repo/history_tracker_repo_Impl.dart';
import 'package:doctor_app/repos/patient_local_repo/patient_local_repo.dart';
import 'package:doctor_app/repos/patient_repo/patient_repo_impl.dart';
import 'package:doctor_app/repos/post_review_repo/post_review_repo.dart';

import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/repos/question_repo/question_repo.dart';
import 'package:doctor_app/repos/session_detail_repo/sessions_detail_repo.dart';
import 'package:doctor_app/repos/slider_repo/slider_local_repo.dart';
import 'package:doctor_app/repos/slider_repo/slider_repo.dart';
import 'package:doctor_app/screens/assessments/bloc/consultant_assesmant_bloc.dart';
import 'package:doctor_app/screens/auth_screen/bloc/login_bloc.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_event.dart';
import 'package:doctor_app/screens/history_tracker_screen/bloc/history_tracker_bloc.dart';
import 'package:doctor_app/screens/home/bloc/home_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nfc_card/bloc/nfc_card_bloc.dart';
import 'package:doctor_app/screens/nfc_card/nfc_card.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/seesion/bloc/session_bloc.dart';
import 'package:doctor_app/screens/seesion/sessiom_detail_screen.dart';
import 'package:doctor_app/screens/visits_detail/bloc/visit_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app_routes/generate_route.dart';
import 'core/navigation_theme.dart';
import 'data/api_service/base_api/base_api.dart';
import 'data/local_storage/local_curd_base/local_curd_impl.dart';
import 'repos/auth_repo/auth_repo_base.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint("FLUTTER ERROR:");
    debugPrint(details.exceptionAsString());
    debugPrint(details.stack.toString());
  };
  // Keep the native white+logo splash until the first real screen is ready.
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  runApp(const MyApp());

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.black, // 👈 background color
      systemNavigationBarIconBrightness: Brightness.light, // 👈 icons color
    ),
  );
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
  late HistoryTrackerRepoImpl historyTrackerRepoImpl;
  late ConsultantAssessmentRepo consultantAssessmentRepo;
  late SessionsDetailRepo sessionsDetailRepo;
  late AllVisitLocalRepo allVisitLocalRepo;
  late AllVisitRepo allVisitRepo;
  late AllConsultantAssessmentLocalRepo allConsultantAssessmentLocalRepo;
  late AllConsultantAssessmentRepo allConsultantAssessmentRepo;
  late AllTherapySessionRepo allTherapySessionRepo;
  late AllTherapySessionLocalRepo allTherapySessionLocalRepo;
  late AllPackagesLocalRepo allPackagesLocalRepo;
  late AllPackagesRepo allPackagesRepo;
  late SliderImagesLocalRepo sliderImagesLocalRepo;
  late SliderRepo sliderRepo;
  late QuestionRepo questionRepo;
  late PostReviewRepo postReviewRepo;

  @override
  void initState() {
    super.initState();
    curdImpl = LocalCurdImpl();
    profileLocalRepo = ProfileLocalRepo(curdBase: curdImpl);
    patientLocalRepo = PatientLocalRepo(curdBase: curdImpl);
    apiImpl = BaseApiImpl();

    patientRepoImpl = PatientRepoImpl(
      api: apiImpl,
      profileLocalRepo: profileLocalRepo,
      curdBase: curdImpl,
      patientLocalRepo: patientLocalRepo,
    );
    allPackagesLocalRepo = AllPackagesLocalRepo(localCurdBase: curdImpl);
    allPackagesRepo = AllPackagesRepo(
      api: apiImpl,
      localRepo: allPackagesLocalRepo,
    );

    allVisitLocalRepo = AllVisitLocalRepo(localCurdBase: curdImpl);

    historyTrackerRepoImpl = HistoryTrackerRepoImpl(
      api: apiImpl,
      curdBase: curdImpl,
    );

    consultantAssessmentRepo = ConsultantAssessmentRepo(api: apiImpl);

    sessionsDetailRepo = SessionsDetailRepo(api: apiImpl);

    allVisitLocalRepo = AllVisitLocalRepo(localCurdBase: curdImpl);

    allVisitRepo = AllVisitRepo(
      api: apiImpl,
      allVisitLocalRepo: AllVisitLocalRepo(localCurdBase: curdImpl),
    );

    allConsultantAssessmentLocalRepo = AllConsultantAssessmentLocalRepo(
      localCurdBase: curdImpl,
    );

    allConsultantAssessmentRepo = AllConsultantAssessmentRepo(
      api: apiImpl,
      allConsultantAssessmentLocalRepo: allConsultantAssessmentLocalRepo,
    );
    allTherapySessionLocalRepo = AllTherapySessionLocalRepo(
      localCurdBase: curdImpl,
    );
    authRepoBase = AuthRepoImpl(
      allTherapySessionLocalRepo: allTherapySessionLocalRepo,
      allConsultantAssessmentLocalRepo: allConsultantAssessmentLocalRepo,
      allVisitLocalRepo: allVisitLocalRepo,
      patientLocalRepo: patientLocalRepo,
      api: apiImpl,
      localRepo: profileLocalRepo,
    );

    allTherapySessionRepo = AllTherapySessionRepo(
      api: apiImpl,
      localRepo: allTherapySessionLocalRepo,
    );
    sliderImagesLocalRepo = SliderImagesLocalRepo(localCurdBase: curdImpl);
    sliderRepo = SliderRepo(api: apiImpl, localRepo: sliderImagesLocalRepo);
    questionRepo = QuestionRepo(api: apiImpl);
    postReviewRepo = PostReviewRepo(api: apiImpl);
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
          create: (context) => HomeBloc(
            sliderImagesLocalRepo: sliderImagesLocalRepo,
            sliderRepo: sliderRepo,
            allPackagesLocalRepo: allPackagesLocalRepo,
            allPackagesRepo: allPackagesRepo,
          ),
        ),

        BlocProvider(
          create: (context) => NaveBarBloc(
            profileLocalRepo: profileLocalRepo,
            authRepo: authRepoBase,
          ),
        ),

        BlocProvider(
          create: (context) => ProfileBloc(
            patientRepoBase: patientRepoImpl,
            authRepoBase: authRepoBase,
            profileLocalRepo: profileLocalRepo,
            patientLocalRepo: patientLocalRepo,
          ),
        ),

        BlocProvider(
          create: (context) => DashboardBloc(
            profileLocalRepo: profileLocalRepo,
            patientRepoBase: patientRepoImpl,
            patientLocalRepo: patientLocalRepo,
          )..add(DashboardRefreshDataEvent()),
        ),

        BlocProvider(
          create: (context) => HistoryTrackerBloc(
            historyTrackerRepoImpl: historyTrackerRepoImpl,
            profileLocalRepo: profileLocalRepo,
          ),
        ),

        BlocProvider(
          create: (context) => ConsultantAssessmentBloc(
            allConsultantAssessmentLocalRepo: allConsultantAssessmentLocalRepo,
            allConsultantAssessmentRepo: allConsultantAssessmentRepo,
            patientLocalRepo: patientLocalRepo,
            profileLocalRepo: profileLocalRepo,
            consultantRepo: consultantAssessmentRepo,
          ),
        ),

        BlocProvider(
          create: (context) => TherapySessionBloc(
            allTherapySessionLocalRepo: allTherapySessionLocalRepo,
            allTherapySessionRepo: allTherapySessionRepo,
            patientLocalRepo: patientLocalRepo,
            profileLocalRepo: profileLocalRepo,
            sessionsDetailRepo: sessionsDetailRepo,
          ),
        ),

        BlocProvider(
          create: (context) => VisitDetailBloc(
            patientLocalRepo: patientLocalRepo,
            profileLocalRepo: profileLocalRepo,
            allVisitLocalRepo: allVisitLocalRepo,
            allVisitRepo: allVisitRepo,
            questionRepo: questionRepo,
            postReviewRepo: postReviewRepo,
          ),
        ),
        BlocProvider(
          create: (context) => NfcCardBloc(localRepo: patientLocalRepo),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(390, 844),
        child: MaterialApp.router(
          builder: (context, child) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: AppSystemUi.light,
              child: child ?? const SizedBox.shrink(),
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'Dr.Ali Therapy',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          routerConfig: RouteGenerator.route,
        ),
      ),
    );
  }
}
