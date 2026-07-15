import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/data/models/history_traker_model.dart';
import 'package:doctor_app/repos/history_tracker_repo/history_tracker_repo_Impl.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/history_tracker_screen/bloc/history_tracker_event.dart';
import 'package:doctor_app/screens/history_tracker_screen/bloc/history_tracker_state.dart';
import 'package:flutter/foundation.dart';

class HistoryTrackerBloc
    extends Bloc<HistoryTrackerEvent, HistoryTrackerState> {
  HistoryTrackerRepoImpl historyTrackerRepoImpl;
  ProfileLocalRepo profileLocalRepo;
  HistoryTrackerBloc({
    required this.historyTrackerRepoImpl,
    required this.profileLocalRepo,
  }) : super(HistoryTrackerState()) {
    on<HistoryTrackerEvent>(_historyTrackerEvent);
  }
  HistoryTrackerModel? historyTrackerModel;
  Future _historyTrackerEvent(
    HistoryTrackerEvent event,
    Emitter<HistoryTrackerState> emit,
  ) async {
    try {
      emit(HistoryTLoadingState());
      String? token = await profileLocalRepo.getToken();
      if (token != '' && event.visitId != '') {
        print('from bloc${event.visitId}');
        historyTrackerModel = await historyTrackerRepoImpl.getHistoryTracker(
          token: token ?? "",
          visitId: event.visitId!,
        );

        emit(HistoryTrackerGetState(historyTrackerModel: historyTrackerModel!));
      } else {
        if (kDebugMode) {
          print('Token or id null');
        }
        throw AppExceptions(message: 'Some things went wrong !');
      }
    } catch (err) {
      emit(HistoryTrackerMessageState(message: err.toString()));
    }
  }
}
