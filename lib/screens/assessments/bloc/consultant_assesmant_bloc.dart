import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_impl.dart';
import 'package:doctor_app/data/models/all_consutant_assessment_model.dart';
import 'package:doctor_app/data/models/consultant_assesment_model.dart';
import 'package:doctor_app/data/models/current_patient_model.dart'
    hide ConsultantAssessmentModel;
import 'package:doctor_app/repos/all_consultant_assessment_repo/all_consultant_assessmant_local_repo.dart';
import 'package:doctor_app/repos/consultant_assasment_repo/consultant_assesment_repo.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:flutter/foundation.dart';

import '../../../repos/all_consultant_assessment_repo/all_consultant_assessmant_repo.dart';
import '../../../repos/patient_local_repo/patient_local_repo.dart';
import 'consultant_assesment_event.dart';
import 'consultant_assesment_state.dart';

class ConsultantAssessmentBloc
    extends Bloc<ConsultantAssessmentEvent, ConsultantAssessmentState> {
  ConsultantAssessmentRepo consultantRepo;
  ProfileLocalRepo profileLocalRepo;
  PatientLocalRepo patientLocalRepo;
  AllConsultantAssessmentLocalRepo allConsultantAssessmentLocalRepo;
  AllConsultantAssessmentRepo allConsultantAssessmentRepo;
  ConsultantAssessmentBloc({
    required this.consultantRepo,
    required this.profileLocalRepo,
    required this.patientLocalRepo,
    required this.allConsultantAssessmentLocalRepo,
    required this.allConsultantAssessmentRepo,
  }) : super(ConsultantAssessmentState()) {
    on<ConsultantAssessmentEvent>(_onConsultantAssessmentEvent);
  }
  ConsultantAssessmentModel? consultantAssessmentModel;
  CurrentPatientModel? patientData;
  List<AllConsultantAssessmentModel>? allConsultantAssessmentModel;

  FutureOr _onConsultantAssessmentEvent(
    ConsultantAssessmentEvent event,
    Emitter<ConsultantAssessmentState> emit,
  ) async {
    try {
      emit(ConsultantLoadingState());
      String token = await profileLocalRepo.getToken() ?? '';
      if (token != '' && event.id != null) {
        consultantAssessmentModel = await consultantRepo
            .getConsultantsAssessmentByVisitId(
              visitId: event.id!,
              token: token,
            );
        emit(
          ConsultantLoadedFromRecordsState(model: consultantAssessmentModel),
        );
        if (kDebugMode) {
          print(event.id);
        }
      } else {
        String? token = await profileLocalRepo.getToken();
        patientData = await patientLocalRepo.getPatientDataLocal();
        if (patientData == null) return;
        if (patientData!.patient == null) return;
        String patientId = patientData!.patient!.id.toString();
        if (token != null && patientId.isNotEmpty) {
          // First we will try to get data from local
          if (event.isRefresh) {
            // Here we will get data from server
            allConsultantAssessmentModel = await allConsultantAssessmentRepo
                .getAllConsultantAssessment(token: token, patientId: patientId);
          } else {
            allConsultantAssessmentModel =
                await allConsultantAssessmentLocalRepo
                    .getAllConsultantAssessmentFromLocal();
            if (allConsultantAssessmentModel == null ||
                allConsultantAssessmentModel!.isEmpty) {
              // Here we will get data from server
              allConsultantAssessmentModel = await allConsultantAssessmentRepo
                  .getAllConsultantAssessment(
                    token: token,
                    patientId: patientId,
                  );
            }
          }

          emit(
            ConsultantFromHomeLoaded(
              allConsultantAssessmentModel: allConsultantAssessmentModel,
            ),
          );
        } else {
          if (kDebugMode) {
            print('Somethings went worng');
          }
        }
      }
    } catch (e) {
      emit(ConsultantMessageState(message: e.toString()));
    }
  }
}
