import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/repos/patient_repo/patient_repo_base.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:flutter/foundation.dart';

import '../../../core/app_exceptions/base_exceptions.dart';
import '../../../core/app_keys/local_keys.dart';
import '../../../repos/patient_local_repo/patient_local_repo.dart';
import 'dashboad_states.dart';
import 'dashboard_event.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardStates> {
  PatientRepoBase patientRepoBase;
  PatientLocalRepo patientLocalRepo;
  ProfileLocalRepo profileLocalRepo;
  DashboardBloc({
    required this.patientRepoBase,
    required this.profileLocalRepo,
    required this.patientLocalRepo,
  }) : super(DashboardInitState()) {
    on<DashboardLoadDataEvent>(_onDashboardLoadData);
    on<DashboardRefreshDataEvent>(_onDashboardRefreshData);
  }

  CurrentPatientModel? patientData;
  LoginModel1? profileData;
  Future _onDashboardLoadData(
    DashboardLoadDataEvent event,
    Emitter<DashboardStates> emit,
  ) async {
    // First We have try if exist data in local storage
    // to get patient data and profile data from local storage
    // try {
    emit(DashboardLoadingState());
    patientData = await patientLocalRepo.getPatientDataLocal();
    profileData = await profileLocalRepo.getProfile();

    if (patientData != null && profileData != null) {
      emit(
        DashboardLoadedState(
          patientData: patientData!,
          profileData: profileData!,
        ),
      );
      print('From Local Storage');
    } else {
      emit(DashboardLoadingState());
      // if local storage is empty we will get data from server for patient
      patientData = await patientRepoBase.getPatientData();
      profileData = await profileLocalRepo.getProfile();

      print('From Api');

      emit(
        DashboardLoadedState(
          patientData: patientData!,
          profileData: profileData!,
        ),
      );
    }
    // } catch (e) {
    //   if (kDebugMode) {
    //     print("Dashboard Bloc Error: $e");
    //   }
    //}
  }

  Future<void> _onDashboardRefreshData(
    DashboardRefreshDataEvent event,
    Emitter<DashboardStates> emit,
  ) async {
    try {
      emit(DashboardLoadingState());

      // Refresh Data from server for patient
      patientData = await patientRepoBase.getPatientData();
      profileData = await profileLocalRepo.getProfile();
      print('From Api');
      emit(
        DashboardLoadedState(
          patientData: patientData!,
          profileData: profileData!,
        ),
      );
    } on BaseExceptions catch (e) {
      emit(DashboardMessageState(massage: e.toString()));
    }
  }
}
