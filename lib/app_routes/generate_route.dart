import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/screens/all_packages_screen/all_packages_screen.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/login_screen.dart';
import 'package:doctor_app/screens/auth_screen/reset_password_screen.dart';
import 'package:doctor_app/screens/book_appoinment_screen/appointment_detail_screen.dart';
import 'package:doctor_app/screens/book_appoinment_screen/book_appoinment_screen.dart';
import 'package:doctor_app/screens/book_appoinment_screen/confirm_appointment_screen.dart';
import 'package:doctor_app/screens/book_appoinment_screen/payment_option_screen.dart';
import 'package:doctor_app/screens/book_appoinment_screen/select_date_screen.dart';
import 'package:doctor_app/screens/map_screen.dart';
import 'package:doctor_app/screens/nave_bar.dart';
import 'package:doctor_app/screens/pament_method_screen/bank_transfer_screen.dart';
import 'package:doctor_app/screens/pament_method_screen/cridit_card_payment_screen.dart';
import 'package:doctor_app/screens/pament_method_screen/easypaisa_pament_screen.dart';
import 'package:doctor_app/screens/pament_method_screen/pament_succes_screen.dart';
import 'package:doctor_app/screens/pament_method_screen/wallet_payment_screen.dart';
import 'package:doctor_app/screens/profile_screens/my_profile.dart';
import 'package:doctor_app/screens/profile_screens/profile_screen.dart';
import 'package:doctor_app/screens/profile_screens/update_profile.dart';
import 'package:doctor_app/screens/session_record/session_notes.dart';
import 'package:doctor_app/screens/splash_scree/splash_screen.dart';
import 'package:doctor_app/screens/video_palyer/video_player_screen.dart';
import 'package:doctor_app/screens/wallet_screen/payment_method_screen.dart';
import 'package:doctor_app/screens/wallet_screen/recharge_wallet_screen.dart';
import 'package:doctor_app/screens/wallet_screen/transaction_history.dart';
import 'package:doctor_app/screens/wallet_screen/wallet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/nfc_card/nfc_card.dart';

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
    AppGenerateRoute(
      routeName: AppRoutes.selectDateScreen,
      screen: SelectDateScreen(),
    ),
    AppGenerateRoute(routeName: AppRoutes.loginScreen, screen: LoginScreen()),
    AppGenerateRoute(
      routeName: AppRoutes.restPassword,
      screen: ResetPasswordScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.confirmAppointment,
      screen: ConfirmAppointmentScreen(),
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
      routeName: AppRoutes.paymentOptionScreen,
      screen: PaymentOptionScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.paymentMethodeScreen,
      screen: PaymentMethodScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.walletPaymentScreen,
      screen: WalletPaymentScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.easyPaisaPaymentScreen,
      screen: EasypaisaPaymentScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.bankPaymentScreen,
      screen: BankTransferScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.creditCardPaymentScreen,
      screen: CreditCardPaymentScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.successPaymentScreen,
      screen: PaymentSuccessScreen(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.myNFCCardScreen,
      screen: NfcCard(),
    ),
    AppGenerateRoute(
      routeName: AppRoutes.myProfileScreen,
      screen: MyProfileScreen(),
    ),
    AppGenerateRoute(routeName: AppRoutes.notesScreen, screen: SessionNotes()),
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
