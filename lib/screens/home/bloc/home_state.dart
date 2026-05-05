import 'package:doctor_app/data/models/all_packages_model.dart';
import 'package:doctor_app/data/models/slider_model.dart';

class HomeState {}

class HomeLoadState extends HomeState {
  AllPackagesModel? allPackagesModel;
  SliderModel? sliderModel;
  HomeLoadState({this.allPackagesModel,this.sliderModel});
}

class HomeMessageState extends HomeState {
  String? message;
  HomeMessageState({this.message});
}

class HomeLoadingState extends HomeState {}
