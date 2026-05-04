import 'package:doctor_app/data/models/consultant_assesment_model.dart';

class ConsultantAssessmentEvent {
  final String? id;
  bool isRefresh;
  ConsultantAssessmentEvent({this.id, this.isRefresh = false});
}
