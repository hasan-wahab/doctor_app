import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/repos/patient_local_repo/patient_local_repo.dart';
import 'package:doctor_app/screens/nfc_card/bloc/nfc_card_event.dart';
import 'package:doctor_app/screens/nfc_card/bloc/nfc_card_state.dart';
import 'package:doctor_app/screens/nfc_card/nfc_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nfc_manager/nfc_manager.dart';

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
        const MethodChannel hceChannel = MethodChannel('hce.channel');
        try {
          if (defaultTargetPlatform != TargetPlatform.android) {
            emit(NfcMessageState(message: 'NFC is only supported on Android.'));
            emit(NfcCardDataState(patientModel: patientModel));
            return;
          }
          if (patientModel!.cardUid == null) {
            emit(NfcCardDataState(patientModel: patientModel));
            return;
          }

          bool isNfcOn = false;
          try {
            isNfcOn = await NfcManager.instance.isAvailable();
          } on PlatformException catch (e) {
            final msg = (e.message ?? '').trim();
            emit(
              NfcMessageState(
                message: msg.isNotEmpty
                    ? msg
                    : 'NFC is not supported on this device.',
              ),
            );
            emit(NfcCardDataState(patientModel: patientModel));
            return;
          }

          if (isNfcOn) {
            await hceChannel.invokeMethod<bool>('setData', <String, dynamic>{
              'data': patientModel!.cardUid,
            });
          } else {
            emit(NfcMessageState(message: 'NFC is not available'));
          }
        } on PlatformException catch (e) {
          final msg = (e.message ?? '').trim();
          emit(
            NfcMessageState(
              message: msg.isNotEmpty
                  ? msg
                  : 'NFC is not supported on this device.',
            ),
          );
        } catch (e, st) {
          debugPrint('HCE setData failed: $e\n$st');
          emit(NfcMessageState(message: 'NFC setup failed. Please try again.'));
        }
        emit(NfcCardDataState(patientModel: patientModel));
      } else {
        log('Current patient model is null');
      }
    } catch (e) {
      emit(NfcMessageState(message: e.toString()));
    }
  }
}
