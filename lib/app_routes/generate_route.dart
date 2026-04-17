import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/screens/all_packages_screen/all_packages_screen.dart';
import 'package:doctor_app/screens/assessments/assessment_detail_screen.dart';
import 'package:doctor_app/screens/assestent_manager/assistent_manager.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/login_screen.dart';
import 'package:doctor_app/screens/auth_screen/reset_password_screen.dart';
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

import '../screens/home/search_screen.dart';
import '../screens/invioce/invoice_detail_screen.dart';
import '../screens/nfc_card/nfc_card.dart';
import '../screens/seesion/sessiom_detail_screen.dart';

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
    // AppGenerateRoute(
    //   routeName: AppRoutes.selectDateScreen,
    //   screen: SelectDateScreen(),
    // ),
    AppGenerateRoute(routeName: AppRoutes.loginScreen, screen: LoginScreen()),
    AppGenerateRoute(
      routeName: AppRoutes.restPassword,
      screen: ResetPasswordScreen(),
    ),
    // AppGenerateRoute(
    //   routeName: AppRoutes.confirmAppointment,
    //   screen: ConfirmAppointmentScreen(),
    // ),
    // AppGenerateRoute(
    //   routeName: AppRoutes.bookAppointmentScreen,
    //   screen: BookAppointmentScreen(),
    // ),
    // AppGenerateRoute(
    //   routeName: AppRoutes.appointmentDetailScreen,
    //   screen: AppointmentDetailScreen(),
    // ),
    // AppGenerateRoute(
    //   routeName: AppRoutes.transactionHistoryScreen,
    //   screen: TransactionHistoryScreen(),
    // ),
    // AppGenerateRoute(
    //   routeName: AppRoutes.rechargeScreen,
    //   screen: RechargeWalletScreen(),
    // ),
    // AppGenerateRoute(routeName: AppRoutes.walletScreen, screen: WalletScreen()),
    // // AppGenerateRoute(
    // //   routeName: AppRoutes.paymentOptionScreen,
    // //   screen: PaymentOptionScreen(),
    // // ),
    // AppGenerateRoute(
    //   routeName: AppRoutes.paymentMethodeScreen,
    //   screen: PaymentMethodScreen(),
    // ),
    // AppGenerateRoute(
    //   routeName: AppRoutes.walletPaymentScreen,
    //   screen: WalletPaymentScreen(),
    // ),
    // AppGenerateRoute(
    //   routeName: AppRoutes.easyPaisaPaymentScreen,
    //   screen: EasypaisaPaymentScreen(),
    // ),
    // AppGenerateRoute(
    //   routeName: AppRoutes.bankPaymentScreen,
    //   screen: BankTransferScreen(),
    // ),
    // AppGenerateRoute(
    //   routeName: AppRoutes.creditCardPaymentScreen,
    //   screen: CreditCardPaymentScreen(),
    // ),
    // AppGenerateRoute(
    //   routeName: AppRoutes.successPaymentScreen,
    //   screen: PaymentSuccessScreen(),
    // ),
    AppGenerateRoute(routeName: AppRoutes.myNFCCardScreen, screen: NfcCardPage()),
    AppGenerateRoute(
      routeName: AppRoutes.myProfileScreen,
      screen: MyProfileScreen(),
    ),
    AppGenerateRoute(routeName: AppRoutes.notesScreen, screen: SessionNotes()),
    AppGenerateRoute(
      routeName: AppRoutes.visitsDetailScreen,
      screen: VisitsDetailScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.packagesDetailScreen,
      screen: PackagesScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.invoiceDetailScreen,
      screen: InvoiceDetailScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.assessmentScreen,
      screen: AssessmentDetailScreen(),
    ),
    AppGenerateRoute(routeName: AppRoutes.searchScreen, screen: SearchScreen()),
    AppGenerateRoute(
      routeName: AppRoutes.assistantManagerScreen,
      screen: AssistantManagerScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.sessionsDetailScreen,
      screen: SessionDetailScreen(),
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
        builder: (context) => LoginScreen(),
        settings: settings,
      );
    }
  }
}
