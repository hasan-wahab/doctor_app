import 'package:doctor_app/data/models/consultant_assesment_model.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';

class ConsultantAssessmentState {}

class ConsultantLoadingState extends ConsultantAssessmentState {}

class ConsultantMessageState extends ConsultantAssessmentState {
  final String? message;
  ConsultantMessageState({this.message = ''});
}

class ConsultantLoadedState extends ConsultantAssessmentState {
  ConsultantAssessmentModel? model;

  ConsultantLoadedState({this.model});
}

class ConsultantFromHomeLoaded extends ConsultantAssessmentState {
  CurrentPatientModel? patientData;
  LoginModel1? profileData;
  ConsultantFromHomeLoaded({this.patientData, this.profileData});
}
