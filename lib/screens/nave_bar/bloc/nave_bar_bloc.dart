import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_events.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NaveBarBloc extends Bloc<NaveBarEvents, NaveBarStates> {
  NaveBarBloc() : super(NaveBarStates(index: 0)) {
    on<NaveBarEvents>((event, emit) {
      emit(state.copyWith(event.index));
      print("Bloc Index Count # ${state.index}");
    });
  }
}
