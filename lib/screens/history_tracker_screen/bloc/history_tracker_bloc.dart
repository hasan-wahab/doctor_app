import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/data/models/history_traker_model.dart';
import 'package:doctor_app/repos/history_tracker_repo/history_tracker_repo_Impl.dart';
import 'package:doctor_app/screens/history_tracker_screen/bloc/history_tracker_event.dart';
import 'package:doctor_app/screens/history_tracker_screen/bloc/history_tracker_state.dart';

class HistoryTrackerBloc
    extends Bloc<HistoryTrackerEvent, HistoryTrackerState> {
  HistoryTrackerRepoImpl historyTrackerRepoImpl;
  HistoryTrackerBloc({required this.historyTrackerRepoImpl})
    : super(HistoryTrackerState()) {
    on<HistoryTrackerEvent>(_historyTrackerEvent);
  }
  HistoryTrackerModel? historyTrackerModel;
  Future _historyTrackerEvent(
    HistoryTrackerEvent event,
    Emitter<HistoryTrackerState> emit,
  ) async {
    try {
      emit(HistoryTrackerLoadingState());
      if (event.token != '' && event.visitId != '') {
        historyTrackerModel = await historyTrackerRepoImpl.getHistoryTracker(
          token: event.token,
          visitId: event.visitId,
        );
        emit(HistoryTrackerGetState(historyTrackerModel: historyTrackerModel!));
      } else {
        throw AppExceptions(message: 'token or visitId is empty');
      }
    } catch (err) {
      emit(HistoryTrackerMessageState(message: err.toString()));
    }
  }
}
