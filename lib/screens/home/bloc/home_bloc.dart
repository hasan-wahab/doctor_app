import 'package:bloc/bloc.dart';
import 'package:doctor_app/screens/home/bloc/home_event.dart';

import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc():super(HomeState()){

  }
}