import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_impl.dart';
import 'package:doctor_app/data/models/consultant_assesment_model.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/repos/consultant_assasment_repo/consultant_assesment_repo.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';

import '../../../repos/patient_local_repo/patient_local_repo.dart';
import 'consultant_assesment_event.dart';
import 'consultant_assesment_state.dart';

class ConsultantAssessmentBloc
    extends Bloc<ConsultantAssessmentEvent, ConsultantAssessmentState> {
  ConsultantAssessmentRepo consultantRepo;
  ProfileLocalRepo profileLocalRepo;
  PatientLocalRepo patientLocalRepo;
  ConsultantAssessmentBloc({
    required this.consultantRepo,
    required this.profileLocalRepo,
    required this.patientLocalRepo,
  }) : super(ConsultantAssessmentState()) {
    on<ConsultantAssessmentEvent>(_onConsultantAssessmentEvent);
  }
  ConsultantAssessmentModel? consultantAssessmentModel;
  CurrentPatientModel? patientData;
  LoginModel1? profileData;
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
        emit(ConsultantLoadedState(model: consultantAssessmentModel));
        print(event.id);
      } else {
        patientData = await patientLocalRepo.getPatientDataLocal();
        profileData = await profileLocalRepo.getProfile();

        if (patientData != null && profileData != null) {
          emit(
            ConsultantFromHomeLoaded(
              patientData: patientData,
              profileData: profileData,
            ),
          );
        } else {
          emit(ConsultantMessageState(message: "Something went wrong"));
        }
      }
    } catch (e) {
      emit(ConsultantMessageState(message: e.toString()));
    }
  }
}
