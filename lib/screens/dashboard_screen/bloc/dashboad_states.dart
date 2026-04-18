import '../../../data/models/current_patient_model.dart';

abstract class DashboardStates {}

class DashboardInitState extends DashboardStates {}

class DashboardLoadingState extends DashboardStates {}

class DashboardLoadedState extends DashboardStates {
  CurrentPatientModel patientData;

  DashboardLoadedState({required this.patientData});
}

class DashboardMessageState extends DashboardStates {
  final String massage;
  DashboardMessageState({required this.massage});
}
