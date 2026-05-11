import '../../../data/models/current_patient_model.dart';

class NfcCardState {}

class NfcCardDataState extends NfcCardState {
  PatientModel? patientModel;
  NfcCardDataState({this.patientModel});
}

class NfcLoadingState extends NfcCardState {}

class NfcMessageState extends NfcCardState {
  String? message;
  NfcMessageState({this.message});
}
