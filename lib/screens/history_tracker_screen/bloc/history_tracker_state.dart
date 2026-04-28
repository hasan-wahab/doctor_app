import 'package:doctor_app/data/models/history_traker_model.dart';

class HistoryTrackerState {
  HistoryTrackerState();
}

class HistoryTrackerGetState extends HistoryTrackerState {
  HistoryTrackerModel historyTrackerModel;

  HistoryTrackerGetState({required this.historyTrackerModel});
}

class HistoryTrackerLoadingState extends HistoryTrackerState {}

class HistoryTrackerMessageState extends HistoryTrackerState {
  String message;
  HistoryTrackerMessageState({required this.message});
}
