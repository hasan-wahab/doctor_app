import 'package:doctor_app/data/models/all_visits_model.dart';
import 'package:doctor_app/data/models/reviews_question_model.dart';

class VisitDetailState {}

class AllVisitDatilsListState extends VisitDetailState {
  AllVisitsModel? model;
  List<QuestionModel>? question;
  AllVisitDatilsListState({this.model, this.question});
}

class VisitDetailLoadingState extends VisitDetailState {}

class VisitDetailMessageState extends VisitDetailState {
  String message;
  VisitDetailMessageState({this.message = ''});
}
