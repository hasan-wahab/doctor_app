import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/repos/patient_repo/patient_repo_base.dart';
import 'package:flutter/foundation.dart';

import '../../../core/app_keys/local_keys.dart';
import 'dashboad_states.dart';
import 'dashboard_event.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardStates> {
  PatientRepoBase patientRepoBase;
  LocalCurdBase curdBase;
  DashboardBloc({required this.patientRepoBase, required this.curdBase})
    : super(DashboardInitState()) {
    on<DashboardLoadDataEvent>(_onDashboardLoadData);
    on<DashboardRefreshDataEvent>(_onDashboardRefreshData);
  }

  Future _onDashboardLoadData(
    DashboardLoadDataEvent event,
    Emitter<DashboardStates> emit,
  ) async {
    try {
      //  emit(DashboardLoadingState());
      // from local storage
      List<Map<String, Object?>> jsonResponse = await curdBase.getData(
        tableName: TableName.patientData,
      );

      if (jsonResponse.isNotEmpty) {
        CurrentPatientModel localPatientModel = CurrentPatientModel.fromJson(
          jsonDecode(jsonResponse[0][LocalKeys.patientKey] as String),
        );
        if (kDebugMode) {
          print(localPatientModel.patient!.user!.name);
        }
        emit(DashboardLoadedState(patientData: localPatientModel));
      } else {
        emit(DashboardLoadingState());
        // from api
        CurrentPatientModel patientData = await patientRepoBase
            .getPatientData();
        if (kDebugMode) {
          print(patientData);
        }
        emit(DashboardLoadedState(patientData: patientData));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Local Error ${e.toString()}");
      }
      emit(DashboardMessageState(massage: e.toString()));
    }
  }

  Future _onDashboardRefreshData(
    DashboardRefreshDataEvent event,
    Emitter<DashboardStates> emit,
  ) async {
    try {
      emit(DashboardLoadingState());
      // from api
      CurrentPatientModel patientData = await patientRepoBase.getPatientData();
      emit(DashboardLoadedState(patientData: patientData));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(DashboardMessageState(massage: "refresh error ${e.toString()}"));
    }
  }
}
