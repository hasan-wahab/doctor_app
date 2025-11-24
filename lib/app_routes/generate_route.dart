import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/screens/all_packages_screen/all_packages_screen.dart';
import 'package:doctor_app/screens/map_screen.dart';
import 'package:doctor_app/screens/nave_bar.dart';
import 'package:doctor_app/screens/video_palyer/video_player_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppGenerateRoute {
  String routeName;
  Widget screen;

  AppGenerateRoute({required this.routeName, required this.screen});
  static List<AppGenerateRoute> route() => [
    AppGenerateRoute(routeName: AppRoutes.naveBar, screen: NaveBar()),
    AppGenerateRoute(
      routeName: AppRoutes.allPackagesScreen,
      screen: AllPackagesScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.videoPlayerScreen,
      screen: VideoPlayerScreen(),
    ),
  ];

  static CupertinoPageRoute onGenerateRoute(
    RouteSettings settings,
    BuildContext context,
  ) {
    final result = route().where((routes) {
      return routes.routeName == settings.name;
    });
    if (result.isNotEmpty) {
      return CupertinoPageRoute(
        builder: (context) => result.first.screen,
        settings: settings,
      );
    } else {
      return CupertinoPageRoute(
        builder: (context) => MapScreen(),
        settings: settings,
      );
    }
  }
}
