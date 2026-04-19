import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/core/app_keys/api_keys.dart';

import 'package:doctor_app/screens/auth_screen/bloc/login_events.dart';
import 'package:doctor_app/screens/auth_screen/bloc/login_states.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:doctor_app/screens/dashboard_screen/bloc/dashboard_event.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:flutter/foundation.dart';

import '../../../repos/auth_repo/auth_repo_base.dart';
import '../../../repos/patient_local_repo/patient_local_repo.dart';
import '../../../repos/profile_local_repo/profile_local_repo.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  final AuthRepoBase authRepo;
  final ProfileLocalRepo profileLocalRepo;

  LoginBloc({required this.profileLocalRepo, required this.authRepo})
    : super(LoginInitState()) {
    on<LoginSignInEvent>(userLogin);
    on<LoginLogoutEvent>((event, emit) {
      userLogout(event, emit);
    });
  }

  Future userLogin(LoginSignInEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());
      await authRepo.userLogin(
        email: event.email.toString(),
        password: event.password.toString(),
      );
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(error: e.toString()));
    }
  }

  FutureOr<void> userLogout(
    LoginLogoutEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    String? token = await profileLocalRepo.getToken();
    if (token != '') {
      await authRepo.logoutUser(token: token ?? '', url: ApiKeys.logoutKey);
      if (emit.isDone) return;
      emit(LoginUserLogoutSuccessState());
    }
  }
}
