import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/data/models/all_packages_model.dart';
import 'package:doctor_app/data/models/slider_model.dart';
import 'package:doctor_app/repos/all_packages_repo/all_packages_local_repo.dart';
import 'package:doctor_app/repos/all_packages_repo/all_packages_repo.dart';
import 'package:doctor_app/repos/all_therapy_session_repo/all_therapy_session_local_repo.dart';
import 'package:doctor_app/repos/slider_repo/slider_local_repo.dart';
import 'package:doctor_app/repos/slider_repo/slider_repo.dart';
import 'package:doctor_app/screens/home/bloc/home_event.dart';

import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AllPackagesRepo allPackagesRepo;
  AllPackagesLocalRepo allPackagesLocalRepo;
  SliderRepo sliderRepo;
  SliderImagesLocalRepo sliderImagesLocalRepo;

  HomeBloc({
    required this.allPackagesLocalRepo,
    required this.allPackagesRepo,
    required this.sliderImagesLocalRepo,
    required this.sliderRepo,
  }) : super(HomeState()) {
    on<HomeLoadEvent>(_onHomeLoadEvent);
  }

  AllPackagesModel? allPackagesModel;
  List<SliderModel>? sliderModel;
  FutureOr<void> _onHomeLoadEvent(
    HomeLoadEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoadingState());
      // await sliderImagesLocalRepo.deleteSliderImages();
      // await allPackagesLocalRepo.deleteAllPackages();
      // First we will try to get data from local storage
      allPackagesModel = await allPackagesLocalRepo.getAllPackagesFromLocal();
      sliderModel = await sliderImagesLocalRepo.getSliderImages();
      if (allPackagesModel != null &&
          allPackagesModel!.packages.isNotEmpty &&
          sliderModel != null) {
        emit(
          HomeLoadState(
            allPackagesModel: allPackagesModel,
            sliderModel: sliderModel,
          ),
        );
      } else {
        // Here we will get data from api
        allPackagesModel = await allPackagesRepo.getAllPackages();
        sliderModel = await sliderRepo.getSliderImages();
        emit(
          HomeLoadState(
            allPackagesModel: allPackagesModel,
            sliderModel: sliderModel,
          ),
        );
      }
    } catch (e) {
      emit(HomeMessageState(message: e.toString()));
    }
  }
}
