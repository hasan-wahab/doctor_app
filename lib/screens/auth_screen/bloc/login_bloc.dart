import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:doctor_app/screens/auth_screen/bloc/login_events.dart';
import 'package:doctor_app/screens/auth_screen/bloc/login_states.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:flutter/foundation.dart';

import '../../../repos/auth_repo/auth_repo_base.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  final AuthRepoBase authRepo;

  LoginBloc({required this.authRepo}) : super(LoginInitState()) {
    on<LoginEvents>((event, emit) => userLogin(event, emit, authRepo));
  }
}

Future userLogin(
  LoginEvents event,
  Emitter<LoginState> emit,
  AuthRepoBase authRepo,
) async {
  try {
    emit(LoginLoadingState());
    await authRepo
        .userLogin(
          email: event.email.toString(),
          password: event.password.toString(),
        )
        .then((_) {
          emit(LoginSuccessState());
        });
  } catch (e) {
    emit(LoginErrorState(error: e.toString()));
  }
}
