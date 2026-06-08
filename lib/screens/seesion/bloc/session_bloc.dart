import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_impl.dart';
import 'package:doctor_app/data/models/all_therapist_model.dart';
import 'package:doctor_app/data/models/consultant_assesment_model.dart';
import 'package:doctor_app/data/models/current_patient_model.dart'
    hide ConsultantAssessmentModel;
import 'package:doctor_app/data/models/therapay_session_model.dart';
import 'package:doctor_app/repos/all_therapy_session_repo/all_therapy_session_local_repo.dart';
import 'package:doctor_app/repos/all_therapy_session_repo/all_therapy_session_repo.dart';
import 'package:doctor_app/repos/consultant_assasment_repo/consultant_assesment_repo.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/repos/session_detail_repo/sessions_detail_repo.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/seesion/bloc/session_event.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../../../repos/patient_local_repo/patient_local_repo.dart';

import 'session_state.dart';

class TherapySessionBloc
    extends Bloc<TherapySessionEvent, TherapySessionState> {
  SessionsDetailRepo sessionsDetailRepo;
  ProfileLocalRepo profileLocalRepo;
  PatientLocalRepo patientLocalRepo;
  AllTherapySessionLocalRepo allTherapySessionLocalRepo;
  AllTherapySessionRepo allTherapySessionRepo;
  TherapySessionBloc({
    required this.sessionsDetailRepo,
    required this.profileLocalRepo,
    required this.patientLocalRepo,
    required this.allTherapySessionRepo,
    required this.allTherapySessionLocalRepo,
  }) : super(TherapySessionState()) {
    on<TherapySessionEvent>(_onAllTherapySessionEvent);
  }
  TherapySessionsResponseModel? therapySessionsResponseModel;
  CurrentPatientModel? patientData;
  LoginModel1? profileData;
  AllTerapistModle? allTherapistModel;
  FutureOr _onAllTherapySessionEvent(
    TherapySessionEvent event,
    Emitter<TherapySessionState> emit,
  ) async {
    try {
      emit(SessionLoadingState());
      String token = await profileLocalRepo.getToken() ?? '';
      if (token != '' && event.id != null) {
        therapySessionsResponseModel = await sessionsDetailRepo
            .getTherapySessionByVisitId(visitId: event.id!, token: token);
        emit(
          SessionLoadedFromRecordsState(model: therapySessionsResponseModel),
        );
        print(event.id);
      }
      else
      {
        patientData = await patientLocalRepo.getPatientDataLocal();
        profileData = await profileLocalRepo.getProfile();

        if (event.refresh == true) {
          allTherapistModel = await allTherapySessionRepo.getAllTherapySession(
            token: token,
            patientId: patientData!.patient!.displayId,
          );
          emit(
            SessionFromHomeLoaded(
              profileData: profileData,
              patientData: patientData,
              allTherapistModel: allTherapistModel,
            ),
          );
        } else {
          // First we wil try to get from local
          allTherapistModel = await allTherapySessionLocalRepo
              .getAllTherapySession();

          if (allTherapistModel != null &&
              allTherapistModel!.visitWiseSessions!.isNotEmpty) {
            print('From Local All Thrapist');
            allTherapistModel = await allTherapySessionLocalRepo
                .getAllTherapySession();
          } else {
            print('From Api All Thrapist');

            allTherapistModel = await allTherapySessionRepo
                .getAllTherapySession(
                  token: token,
                  patientId: patientData!.patient!.displayId,
                );
          }
          if (patientData != null &&
              profileData != null &&
              allTherapistModel != null) {
            emit(
              SessionFromHomeLoaded(
                allTherapistModel: allTherapistModel,
                patientData: patientData,
                profileData: profileData,
              ),
            );
          } else {
            emit(SessionMessageState(message: "Something went wrong"));
          }
        }
      }
    } catch (e) {
      emit(SessionMessageState(message: e.toString()));
    }
  }
}
