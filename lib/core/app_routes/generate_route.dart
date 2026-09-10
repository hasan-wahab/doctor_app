import 'package:doctor_app/core/app_routes/routes_name.dart';
import 'package:doctor_app/screens/all_packages_screen/all_packages_screen.dart';
import 'package:doctor_app/screens/assessments/assessment_detail_screen.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/login_screen.dart';
import 'package:doctor_app/screens/history_tracker_screen/history_tracker_screen.dart';
import 'package:doctor_app/screens/location/location_screen.dart';
import 'package:doctor_app/screens/nave_bar/nave_bar.dart';
import 'package:doctor_app/screens/packages/packages_screen.dart';

import 'package:doctor_app/screens/profile_screens/my_profile.dart';
import 'package:doctor_app/screens/profile_screens/profile_screen.dart';
import 'package:doctor_app/screens/profile_screens/update_profile.dart';
import 'package:doctor_app/screens/session_record/session_notes.dart';
import 'package:doctor_app/screens/splash_scree/splash_screen.dart';
import 'package:doctor_app/screens/video_palyer/video_player_screen.dart';
import 'package:doctor_app/screens/visits_detail/visits_detail_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/home/search_screen.dart';
import '../../screens/invioce/invoice_detail_screen.dart';
import '../../screens/nfc_card/nfc_card.dart';
import '../../screens/seesion/sessiom_detail_screen.dart';
import 'package:go_router/go_router.dart';

// class AppGenerateRoute {
//   String routeName;
//   Widget screen;
//
//   AppGenerateRoute({required this.routeName, required this.screen});
//   static List<AppGenerateRoute> route() => [
//     AppGenerateRoute(routeName: AppRoutes.splashScreen, screen: SplashScreen()),
//     AppGenerateRoute(routeName: AppRoutes.naveBar, screen: NaveBar()),
//     AppGenerateRoute(
//       routeName: AppRoutes.allPackagesScreen,
//       screen: AllPackagesScreen(),
//     ),
//     AppGenerateRoute(
//       routeName: AppRoutes.updateProfile,
//       screen: UpdateProfile(),
//     ),
//     AppGenerateRoute(
//       routeName: AppRoutes.profileScreen,
//       screen: ProfileScreen(),
//     ),
//
//     AppGenerateRoute(
//       routeName: AppRoutes.videoPlayerScreen,
//       screen: VideoPlayerScreen(),
//     ),
//     AppGenerateRoute(routeName: AppRoutes.loginScreen, screen: LoginScreen()),
//
//     AppGenerateRoute(
//       routeName: AppRoutes.myNFCCardScreen,
//       screen: NfcCardPage(),
//     ),
//
//     AppGenerateRoute(
//       routeName: AppRoutes.myProfileScreen,
//       screen: MyProfileScreen(),
//     ),
//     AppGenerateRoute(routeName: AppRoutes.notesScreen, screen: SessionNotes()),
//     AppGenerateRoute(
//       routeName: AppRoutes.visitsDetailScreen,
//       screen: VisitsDetailScreen(),
//     ),
//     AppGenerateRoute(
//       routeName: AppRoutes.packagesDetailScreen,
//       screen: PackagesScreen(),
//     ),
//     AppGenerateRoute(
//       routeName: AppRoutes.invoiceDetailScreen,
//       screen: InvoiceDetailScreen(),
//     ),
//     AppGenerateRoute(routeName: AppRoutes.mapScreen, screen: LocationScreen()),
//     AppGenerateRoute(
//       routeName: AppRoutes.assessmentScreen,
//       screen: AssessmentDetailScreen(),
//     ),
//     //  AppGenerateRoute(routeName: AppRoutes.searchScreen, screen: SearchScreen()),
//     AppGenerateRoute(
//       routeName: AppRoutes.sessionsDetailScreen,
//       screen: SessionDetailScreen(),
//     ),
//     AppGenerateRoute(
//       routeName: AppRoutes.historyTrackerScreen,
//       screen: HistoryTrackerScreen(),
//     ),
//   ];
//
//   static CupertinoPageRoute onGenerateRoute(
//     RouteSettings settings,
//     BuildContext context,
//   ) {
//     final result = route().where((routes) {
//       return routes.routeName == settings.name;
//     });
//     if (result.isNotEmpty) {
//       return CupertinoPageRoute(
//         builder: (context) => result.first.screen,
//         settings: settings,
//       );
//     } else {
//       return CupertinoPageRoute(
//         builder: (context) => LoginScreen(),
//         settings: settings,
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_app/core/app_routes/routes_name.dart';
import 'package:doctor_app/core/functions.dart';
import 'package:doctor_app/screens/all_packages_screen/all_packages_screen.dart';
import 'package:doctor_app/screens/assessments/assessment_detail_screen.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/login_screen.dart';
import 'package:doctor_app/screens/history_tracker_screen/history_tracker_screen.dart';
import 'package:doctor_app/screens/location/location_screen.dart';
import 'package:doctor_app/screens/nave_bar/nave_bar.dart';
import 'package:doctor_app/screens/packages/packages_screen.dart';
import 'package:doctor_app/screens/profile_screens/my_profile.dart';
import 'package:doctor_app/screens/profile_screens/profile_screen.dart';
import 'package:doctor_app/screens/profile_screens/update_profile.dart';
import 'package:doctor_app/screens/session_record/session_notes.dart';
import 'package:doctor_app/screens/splash_scree/splash_screen.dart';
import 'package:doctor_app/screens/video_palyer/video_player_screen.dart';
import 'package:doctor_app/screens/visits_detail/visits_detail_screen.dart';
import 'package:doctor_app/screens/invioce/invoice_detail_screen.dart';
import 'package:doctor_app/screens/nfc_card/nfc_card.dart';
import 'package:doctor_app/screens/seesion/sessiom_detail_screen.dart';

class RouteGenerator {
  /// 🔥 FIXED ROUTE HELPER
  static GoRoute _goRoute({
    required String routeName,
    required Widget Function(BuildContext context, GoRouterState state) screen,
    String? Function(BuildContext context, GoRouterState state)? redirect,
  }) {
    return GoRoute(
      path: routeName,
      redirect: redirect,
      builder: (context, state) => screen(context, state),
    );
  }

  /// 🔥 MAIN ROUTER
  static GoRouter get route => GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      _goRoute(
        routeName: AppRoutes.splashScreen,
        screen: (context, state) => SplashScreen(),
      ),
      _goRoute(
        routeName: AppRoutes.naveBar,

        screen: (context, state) => NaveBar(),
      ),
      _goRoute(
        routeName: AppRoutes.loginScreen,
        screen: (context, state) => LoginScreen(),
      ),
      _goRoute(
        routeName: AppRoutes.notesScreen,
        screen: (context, state) => SessionNotes(),
      ),
      _goRoute(
        routeName: AppRoutes.mapScreen,
        screen: (context, state) => LocationScreen(),
      ),
      _goRoute(
        routeName: AppRoutes.historyTrackerScreen,
        screen: (context, state) =>
            HistoryTrackerScreen(visitId: state.extra?.toString()),
      ),
      _goRoute(
        routeName: AppRoutes.sessionsDetailScreen,
        screen: (context, state) {
          return SessionDetailScreen(visitId: state.extra?.toString());
        },
      ),
      _goRoute(
        routeName: AppRoutes.assessmentScreen,
        screen: (context, state) {
          return AssessmentDetailScreen(visitId: state.extra?.toString());
        },
      ),
      _goRoute(
        routeName: AppRoutes.invoiceDetailScreen,
        screen: (context, state) => InvoiceDetailScreen(),
      ),
      _goRoute(
        routeName: AppRoutes.packagesDetailScreen,
        screen: (context, state) => PackagesScreen(),
      ),
      _goRoute(
        routeName: AppRoutes.visitsDetailScreen,
        screen: (context, state) => VisitsDetailScreen(),
      ),
      _goRoute(
        routeName: AppRoutes.myProfileScreen,
        screen: (context, state) => MyProfileScreen(),
      ),
      _goRoute(
        routeName: AppRoutes.myNFCCardScreen,
        // iPhone / iOS: never open the NFC card screen.
        redirect: (context, state) =>
            showNfcCard ? null : AppRoutes.naveBar,
        screen: (context, state) =>
            NfcCardPage(fromProfile: state.extra as bool),
      ),
      _goRoute(
        routeName: AppRoutes.videoPlayerScreen,
        screen: (context, state) =>
            VideoPlayerScreen(videoIndex: state.extra as int),
      ),
      _goRoute(
        routeName: AppRoutes.allPackagesScreen,
        screen: (context, state) =>
            AllPackagesScreen(hasInternet: state.extra as bool),
      ),
      _goRoute(
        routeName: AppRoutes.updateProfile,
        screen: (context, state) => UpdateProfile(),
      ),
      _goRoute(
        routeName: AppRoutes.profileScreen,
        screen: (context, state) => ProfileScreen(),
      ),
    ],
  );
}
