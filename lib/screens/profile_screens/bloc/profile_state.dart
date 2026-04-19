import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';

abstract class ProfileState {}

class MyProfileState extends ProfileState {
  CurrentPatientModel? currentPatientModel;
  LoginModel1? profileData;
  MyProfileState({this.currentPatientModel, this.profileData});
}

class ProfileMessageState extends ProfileState {
  String? message;
  ProfileMessageState({this.message});
}

class ProfileLoadingState extends ProfileState {}
