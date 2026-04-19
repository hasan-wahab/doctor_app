import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_state.dart';

class NaveBarBloc extends Bloc<NaveBarEvent, NaveBarState> {
  ProfileLocalRepo profileLocalRepo;
  NaveBarBloc({required this.profileLocalRepo}) : super(NaveBarState()) {
    on<NaveBarEvent>(_onNavBarIndexEvent);
  }
  _onNavBarIndexEvent(NaveBarEvent event, Emitter<NaveBarState> emit) async {
    String? token = await profileLocalRepo.getToken();
    print(token);
    emit(NaveBarState(index: event.index, token: token));
  }
}
