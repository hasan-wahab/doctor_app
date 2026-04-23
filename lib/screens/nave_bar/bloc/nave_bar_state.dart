import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';

class NaveBarState {}

class NaveBarIndexState extends NaveBarState {
  int index;
  String? token;
  NaveBarIndexState({this.index = 0, this.token = ''});
}

class NaveBarLoadingState extends NaveBarState {}

class NaveBarMessageState extends NaveBarState {
  String? message;
  NaveBarMessageState({this.message = ''});
}
