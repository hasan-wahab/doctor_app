import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/screens/all_packages_screen/all_packages_screen.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/login_screen.dart';
import 'package:doctor_app/screens/auth_screen/reset_password_screen.dart';
import 'package:doctor_app/screens/book_appoinment_screen/appointment_detail_screen.dart';
import 'package:doctor_app/screens/book_appoinment_screen/book_appoinment_screen.dart';
import 'package:doctor_app/screens/map_screen.dart';
import 'package:doctor_app/screens/nave_bar.dart';
import 'package:doctor_app/screens/profile_screens/profile_screen.dart';
import 'package:doctor_app/screens/profile_screens/update_profile.dart';
import 'package:doctor_app/screens/splash_scree/splash_screen.dart';
import 'package:doctor_app/screens/video_palyer/video_player_screen.dart';
import 'package:doctor_app/screens/wallet_screen/payment_method_screen.dart';
import 'package:doctor_app/screens/wallet_screen/recharge_wallet_screen.dart';
import 'package:doctor_app/screens/wallet_screen/transaction_history.dart';
import 'package:doctor_app/screens/wallet_screen/wallet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppGenerateRoute {
  String routeName;
  Widget screen;

  AppGenerateRoute({required this.routeName, required this.screen});
  static List<AppGenerateRoute> route() => [
    AppGenerateRoute(routeName: AppRoutes.splashScreen, screen: SplashScreen()),
    AppGenerateRoute(routeName: AppRoutes.naveBar, screen: NaveBar()),
    AppGenerateRoute(
      routeName: AppRoutes.allPackagesScreen,
      screen: AllPackagesScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.updateProfile,
      screen: UpdateProfile(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.profileScreen,
      screen: ProfileScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.videoPlayerScreen,
      screen: VideoPlayerScreen(),
    ),
    AppGenerateRoute(routeName: AppRoutes.loginScreen, screen: LoginScreen()),
    AppGenerateRoute(
      routeName: AppRoutes.restPassword,
      screen: ResetPasswordScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.bookAppointmentScreen,
      screen: BookAppointmentScreen(),
    ),

    AppGenerateRoute(
      routeName: AppRoutes.appointmentDetailScreen,
      screen: AppointmentDetailScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.transactionHistoryScreen,
      screen: TransactionHistoryScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.rechargeScreen,
      screen: RechargeWalletScreen(),
    ),
    AppGenerateRoute(routeName: AppRoutes.walletScreen, screen: WalletScreen()),
    AppGenerateRoute(
      routeName: AppRoutes.paymentMethodeScreen,
      screen: PaymentMethodScreen(),
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
