import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/repos/auth_repo/auth_repo.dart';
import 'package:doctor_app/repos/auth_repo/auth_repo_base.dart';
import 'package:doctor_app/repos/profile_local_repo/profile_local_repo.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_state.dart';

import '../../../core/app_keys/api_keys.dart';

class NaveBarBloc extends Bloc<NaveBarEvent, NaveBarState> {
  ProfileLocalRepo profileLocalRepo;
  AuthRepoBase authRepo;
  NaveBarBloc({required this.profileLocalRepo, required this.authRepo})
    : super(NaveBarState()) {
    on<NaveBarIndexEvent>(_onNavBarIndexEvent);
    on<NaveBarLogoutEvent>(userLogout);
  }
  _onNavBarIndexEvent(
    NaveBarIndexEvent event,
    Emitter<NaveBarState> emit,
  ) async {
    String? token = await profileLocalRepo.getToken();
    emit(NaveBarIndexState(index: event.index, token: token ?? ''));
  }

  FutureOr<void> userLogout(
    NaveBarLogoutEvent event,
    Emitter<NaveBarState> emit,
  ) async {
    try {
      emit(NaveBarLoadingState());
      String? token = await profileLocalRepo.getToken() ?? '';
      if (token != '') {
        await authRepo.logoutUser(token: token, url: ApiKeys.logoutKey);
        emit(NaveBarIndexState(index: 0, token: ''));
      } else {
        throw AppExceptions(message: 'Token null', debugMessage: 'Token null');
      }
    } catch (e) {
      emit(NaveBarMessageState(message: e.toString()));
    }
  }
}
