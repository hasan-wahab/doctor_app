import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/repos/auth_repo/auth_repo_base.dart';
import 'package:doctor_app/repos/patient_local_repo/patient_local_repo.dart';
import 'package:doctor_app/repos/patient_repo/patient_repo_base.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';
import 'package:flutter/foundation.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileState> {
  ProfileLocalRepo profileLocalRepo;
  PatientLocalRepo patientLocalRepo;
  AuthRepoBase authRepoBase;
  PatientRepoBase patientRepoBase;
  ProfileBloc({
    required this.patientLocalRepo,
    required this.profileLocalRepo,
    required this.authRepoBase,
    required this.patientRepoBase,
  }) : super(MyProfileState()) {
    on<MyProfileEvent>(myProfileData);
    on<UpdateProfileEvent>(updateProfileData);
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
      List<VisitModel> visits = List.from(patientData!.patient!.visits);
      var therapySessions = List.from(patientData!.therapySessions);

      visits.sort((a, b) => a.displayVisitAt!.compareTo(b.displayVisitAt));
      emit(
        MyProfileState(
          currentPatientModel: patientData,
          profileData: profileData,
          visits: visits,
          therapaySessions: therapySessions,
        ),
      );
    } else {
      emit(ProfileMessageState(message: "Something went wrong"));
    }
  }

  Future updateProfileData(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoadingState());
      String? token = await profileLocalRepo.getToken();
      if (token != null) {
        await authRepoBase.updateUserProfile(
          file: event.path ?? File(''),
          name: event.name,
          email: event.email,
          cnic: event.cnic,
          phone: event.phone,
          birthDate: event.birthDate,
          gender: event.gender,
          token: token,
        );
        profileData = await profileLocalRepo.getProfile();
        patientData = await patientRepoBase.getPatientData();
        emit(
          MyProfileState(
            profileData: profileData,
            currentPatientModel: patientData,
          ),
        );
      }
    } catch (e) {
      // print(e.toString());
      emit(ProfileMessageState(message: e.toString()));
    }
  }
}
