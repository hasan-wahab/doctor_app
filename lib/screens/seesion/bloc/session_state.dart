import 'package:doctor_app/data/models/consultant_assesment_model.dart';
import 'package:doctor_app/data/models/current_patient_model.dart'
    hide ConsultantAssessmentModel;
import 'package:doctor_app/data/models/therapay_session_model.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';

import '../../../data/models/all_therapist_model.dart';

class TherapySessionState {}

class SessionLoadingState extends TherapySessionState {}

class SessionMessageState extends TherapySessionState {
  final String? message;
  SessionMessageState({this.message = ''});
}

class SessionLoadedFromRecordsState extends TherapySessionState {
  TherapySessionsResponseModel? model;

  SessionLoadedFromRecordsState({this.model});
}

class SessionFromHomeLoaded extends TherapySessionState {
  CurrentPatientModel? patientData;
  LoginModel1? profileData;
  AllTherapistModel? allTherapistModel;
  SessionFromHomeLoaded({this.patientData, this.profileData,this.allTherapistModel});
}
