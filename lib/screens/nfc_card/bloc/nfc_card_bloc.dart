import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/repos/patient_local_repo/patient_local_repo.dart';
import 'package:doctor_app/screens/nfc_card/bloc/nfc_card_event.dart';
import 'package:doctor_app/screens/nfc_card/bloc/nfc_card_state.dart';
import 'package:doctor_app/screens/nfc_card/nfc_card.dart';

class NfcCardBloc extends Bloc<NfcCardEvent, NfcCardState> {
  PatientLocalRepo localRepo;
  NfcCardBloc({required this.localRepo}) : super(NfcCardState()) {
    on<NfcCardEvent>(_onNfcCardEvent);
  }
  CurrentPatientModel? currentPatientModel;
  PatientModel? patientModel;
  FutureOr<void> _onNfcCardEvent(
    NfcCardEvent event,
    Emitter<NfcCardState> emit,
  ) async {
    emit(NfcLoadingState());
    try {
      currentPatientModel = await localRepo.getPatientDataLocal();
      if (currentPatientModel != null) {
        patientModel = currentPatientModel!.patient;
        emit(NfcCardDataState(patientModel: patientModel));
      } else {
        log('Current patient model is null');
      }
    } catch (e) {
      emit(NfcMessageState(message: e.toString()));
    }
  }
}
