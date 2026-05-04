import 'package:doctor_app/data/models/all_consutant_assessment_model.dart';
import 'package:doctor_app/data/models/consultant_assesment_model.dart';
import 'package:doctor_app/data/models/current_patient_model.dart'
    hide ConsultantAssessmentModel;
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';

class ConsultantAssessmentState {}

class ConsultantLoadingState extends ConsultantAssessmentState {}

class ConsultantMessageState extends ConsultantAssessmentState {
  final String? message;
  ConsultantMessageState({this.message = ''});
}

class ConsultantLoadedFromRecordsState extends ConsultantAssessmentState {
  ConsultantAssessmentModel? model;

  ConsultantLoadedFromRecordsState({this.model});
}

class ConsultantFromHomeLoaded extends ConsultantAssessmentState {
  List<AllConsultantAssessmentModel>? allConsultantAssessmentModel = [];
  ConsultantFromHomeLoaded({this.allConsultantAssessmentModel});
}
