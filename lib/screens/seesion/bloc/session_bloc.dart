import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_impl.dart';
import 'package:doctor_app/data/models/consultant_assesment_model.dart';
import 'package:doctor_app/data/models/current_patient_model.dart'
    hide ConsultantAssessmentModel;
import 'package:doctor_app/data/models/therapay_session_model.dart';
import 'package:doctor_app/repos/consultant_assasment_repo/consultant_assesment_repo.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/repos/session_detail_repo/sessions_detail_repo.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/seesion/bloc/session_event.dart';

import '../../../repos/patient_local_repo/patient_local_repo.dart';

import 'session_state.dart';

class TherapySessionBloc
    extends Bloc<TherapySessionEvent, TherapySessionState> {
  SessionsDetailRepo sessionsDetailRepo;
  ProfileLocalRepo profileLocalRepo;
  PatientLocalRepo patientLocalRepo;
  TherapySessionBloc({
    required this.sessionsDetailRepo,
    required this.profileLocalRepo,
    required this.patientLocalRepo,
  }) : super(TherapySessionState()) {
    on<TherapySessionEvent>(_onConsultantAssessmentEvent);
  }
  TherapySessionsResponseModel? therapySessionsResponseModel;
  CurrentPatientModel? patientData;
  LoginModel1? profileData;
  FutureOr _onConsultantAssessmentEvent(
    TherapySessionEvent event,
    Emitter<TherapySessionState> emit,
  ) async {
    try {
      emit(SessionLoadingState());
      String token = await profileLocalRepo.getToken() ?? '';
      if (token != '' && event.id != null) {
        therapySessionsResponseModel = await sessionsDetailRepo
            .getConsultantsAssessmentByVisitId(
              visitId: event.id!,
              token: token,
            );
        emit(
          SessionLoadedFromRecordsState(model: therapySessionsResponseModel),
        );
        print(event.id);
      } else {
        patientData = await patientLocalRepo.getPatientDataLocal();
        profileData = await profileLocalRepo.getProfile();

        if (patientData != null && profileData != null) {
          emit(
            SessionFromHomeLoaded(
              patientData: patientData,
              profileData: profileData,
            ),
          );
        } else {
          emit(SessionMessageState(message: "Something went wrong"));
        }
      }
    } catch (e) {
      emit(SessionMessageState(message: e.toString()));
    }
  }
}
