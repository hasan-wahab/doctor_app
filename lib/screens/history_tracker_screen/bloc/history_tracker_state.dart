import 'package:doctor_app/data/models/history_traker_model.dart';

class HistoryTrackerState {}

class HistoryTrackerGetState extends HistoryTrackerState {
  HistoryTrackerModel historyTrackerModel;

  HistoryTrackerGetState({required this.historyTrackerModel});
}

class HistoryTLoadingState extends HistoryTrackerState {}

class HistoryTrackerMessageState extends HistoryTrackerState {
  String message;
  HistoryTrackerMessageState({required this.message});
}
