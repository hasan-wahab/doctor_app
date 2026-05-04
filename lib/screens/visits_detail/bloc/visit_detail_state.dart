import 'package:doctor_app/data/models/all_visits_model.dart';

 class VisitDetailState {}

class AllVisitDatilsListState extends VisitDetailState {
  AllVisitsModel? model;
  AllVisitDatilsListState({this.model});
}

class VisitDetailLoadingState extends VisitDetailState {}

class VisitDetailMessageState extends VisitDetailState {
  String message;
  VisitDetailMessageState({this.message = ''});
}
