import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/repos/patient_local_repo/patient_local_repo.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileState> {
  ProfileLocalRepo profileLocalRepo;
  PatientLocalRepo patientLocalRepo;
  ProfileBloc({required this.patientLocalRepo, required this.profileLocalRepo})
    : super(MyProfileState()) {
    on<MyProfileEvent>(myProfileData);
  }
  LoginModel1? profileData;
  CurrentPatientModel? patientData;
  FutureOr<void> myProfileData(
    MyProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoadingState());
      patientData = await patientLocalRepo.getPatientDataLocal();
      profileData = await profileLocalRepo.getProfile();
    } catch (e) {
      emit(ProfileMessageState(message: e.toString()));
    }
    if (patientData != null && profileData != null) {
      emit(
        MyProfileState(
          currentPatientModel: patientData,
          profileData: profileData,
        ),
      );
    } else {
      emit(ProfileMessageState(message: "Something went wrong"));
    }
  }
}
