import 'package:doctor_app/data/models/current_patient_model.dart';

abstract class PatientRepoBase {
  Future getPatientData();
  Future deletePatientData();
  Future updatePatientData();
}
