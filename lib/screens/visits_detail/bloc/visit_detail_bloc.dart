import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/models/all_visits_model.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/data/models/reviews_question_model.dart';
import 'package:doctor_app/repos/all_visits_repo/all_visits_local_repo.dart';
import 'package:doctor_app/repos/all_visits_repo/all_visits_repo.dart';
import 'package:doctor_app/repos/auth_repo/auth_repo_base.dart';
import 'package:doctor_app/repos/patient_local_repo/patient_local_repo.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/repos/question_repo/question_repo.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/visits_detail/bloc/visit_detail_event.dart';
import 'package:doctor_app/screens/visits_detail/bloc/visit_detail_state.dart';
import 'package:flutter/foundation.dart';

import '../../../core/app_exceptions/app_exceptions.dart';
import '../../../repos/post_review_repo/post_review_repo.dart';

class VisitDetailBloc extends Bloc<VisitDetailEvent, VisitDetailState> {
  AllVisitRepo allVisitRepo;
  AllVisitLocalRepo allVisitLocalRepo;
  ProfileLocalRepo profileLocalRepo;
  PatientLocalRepo patientLocalRepo;
  QuestionRepo questionRepo;
  PostReviewRepo postReviewRepo;
  VisitDetailBloc({
    required this.allVisitLocalRepo,
    required this.allVisitRepo,
    required this.profileLocalRepo,
    required this.patientLocalRepo,
    required this.questionRepo,
    required this.postReviewRepo,
  }) : super(VisitDetailState()) {
    on<VisitDetailApiAndLocalEvent>(_visitDetailEvent);
    on<VisitDetailJustFromServerEvent>(_visitDetailFromServerEvent);
    on<ReviewSubmitEvent>(_reviewSubmitEvent);
  }

  AllVisitsModel? allVisitsModel;
  FutureOr<void> _visitDetailEvent(VisitDetailEvent event, Emitter emit) async {
    try {
      emit(VisitDetailLoadingState());
      // First we will try to get data from local
      String? token = await profileLocalRepo.getToken();
      allVisitsModel = await allVisitLocalRepo.getAllVisitFromLocal();
      List<QuestionModel> question = await questionRepo.getQuestions(
        token: token!,
      );

      if (allVisitsModel != null && allVisitsModel!.visits.isNotEmpty) {
        debugPrint('All Visit Data From Local');
        emit(
          AllVisitDatilsListState(model: allVisitsModel, question: question),
        );
      } else {
        debugPrint('All Visit Data From Server');
        emit(VisitDetailLoadingState());
        // Here we will get data from server
        String? token = await profileLocalRepo.getToken();

        CurrentPatientModel? currentPatientModel = await patientLocalRepo
            .getPatientDataLocal();
        if (currentPatientModel == null) return;
        if (currentPatientModel.patient == null) return;
        String patientId = currentPatientModel.patient?.id.toString() ?? '';
        if (token != null && patientId.isNotEmpty && patientId != '') {
          List<QuestionModel> question = await questionRepo.getQuestions(
            token: token,
          );
          allVisitsModel = await allVisitRepo.allVisits(
            token: token,
            patientId: patientId,
          );
          emit(
            AllVisitDatilsListState(model: allVisitsModel, question: question),
          );
        } else {
          if (kDebugMode) {
            print('Token Or PatientID Was Null');
          }
        }
      }
    } catch (e) {
      emit(VisitDetailMessageState(message: e.toString()));
    }
  }

  FutureOr<void> _visitDetailFromServerEvent(
    VisitDetailJustFromServerEvent event,
    Emitter<VisitDetailState> emit,
  ) async {
    try {
      debugPrint('All Visit Data From Server');
      emit(VisitDetailLoadingState());
      // Here we will get data from server
      String? token = await profileLocalRepo.getToken();
      CurrentPatientModel? currentPatientModel = await patientLocalRepo
          .getPatientDataLocal();
      if (currentPatientModel == null) return;
      if (currentPatientModel.patient == null) return;
      String patientId = currentPatientModel.patient?.id.toString() ?? '';
      if (token != null && patientId.isNotEmpty && patientId != '') {
        allVisitsModel = await allVisitRepo.allVisits(
          token: token,
          patientId: patientId,
        );
        List<QuestionModel> question = await questionRepo.getQuestions(
          token: token,
        );
        emit(
          AllVisitDatilsListState(question: question, model: allVisitsModel),
        );
      } else {
        if (kDebugMode) {
          print('Token Or PatientID Was Null');
        }
      }
    } catch (e) {
      emit(VisitDetailMessageState(message: e.toString()));
    }
  }

  FutureOr<void> _reviewSubmitEvent(
    ReviewSubmitEvent event,
    Emitter<VisitDetailState> emit,
  ) async {
    try {
      emit(VisitDetailLoadingState());
      String? token = await profileLocalRepo.getToken();
      await postReviewRepo.postReview(
        model: event.postReviewModel,
        token: token ?? '',
      );
      emit(VisitDetailMessageState(message: 'Review Submitted'));

    } catch (e) {
      emit(VisitDetailMessageState(message: e.toString()));
    }
  }
}
