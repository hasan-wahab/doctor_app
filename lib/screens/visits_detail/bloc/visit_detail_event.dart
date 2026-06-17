import 'package:doctor_app/data/models/post_review_model.dart';

abstract class VisitDetailEvent {}

class VisitDetailApiAndLocalEvent extends VisitDetailEvent {}

class VisitDetailJustFromServerEvent extends VisitDetailEvent {}

class ReviewSubmitEvent extends VisitDetailEvent {
  PostReviewModel postReviewModel;
  ReviewSubmitEvent({required this.postReviewModel});
}
