import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';

import '../../../data/models/current_patient_model.dart';

abstract class DashboardStates {}

class DashboardInitState extends DashboardStates {}

class DashboardLoadingState extends DashboardStates {}

class DashboardLoadedState extends DashboardStates {
  CurrentPatientModel patientData;
  LoginModel1 profileData;

  DashboardLoadedState({required this.patientData, required this.profileData});
}

class DashboardMessageState extends DashboardStates {
  final String massage;
  DashboardMessageState({required this.massage});
}
