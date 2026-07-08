import 'dart:convert';

import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api.dart';
import 'package:doctor_app/data/models/slider_model.dart';
import 'package:doctor_app/repos/slider_repo/slider_local_repo.dart';
import 'package:flutter/foundation.dart';

class SliderRepo {
  BaseApi api;
  SliderImagesLocalRepo localRepo;
  SliderRepo({required this.api, required this.localRepo});

  Future<List<SliderModel>> getSliderImages() async {
    final jsonResponse = await api.getApi(url: ApiKeys.sliderKey);

    if (jsonResponse != null) {
      List sliderList = jsonResponse['data'] ?? [];
      List<SliderModel> sliderModelList = sliderList
          .map((e) => SliderModel.fromJson(e))
          .toList();

      await localRepo.deleteSliderImages();
      await localRepo.saveSliderImages(model: sliderModelList);
      return sliderModelList;
    } else {
      if (kDebugMode) {
        print('Json Response null');
      }
      throw AppExceptions(message: 'Something went wrong');
    }
  }
}
