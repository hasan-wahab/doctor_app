import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/api_service/base_api/base_api.dart';
import 'package:doctor_app/data/models/all_packages_model.dart';
import 'package:doctor_app/repos/all_packages_repo/all_packages_local_repo.dart';
import 'package:flutter/foundation.dart';

class AllPackagesRepo {
  BaseApi api;
  AllPackagesLocalRepo localRepo;
  AllPackagesRepo({required this.api, required this.localRepo});

  Future getAllPackages() async {
    AllPackagesModel? model;

    final jsonResponse = await api.getApi(url: ApiKeys.allPackagesKey);
    if (jsonResponse != null) {
      print(jsonResponse);
      model = AllPackagesModel.fromJson(jsonResponse['data']);
      await localRepo.deleteAllPackages();
      await localRepo.saveAllPackagesFromLocal(model: model);
      return model;
    } else {
      if (kDebugMode) {
        print('Json response null');
      }
      throw AppExceptions(message: 'Something went wrong');
    }
  }
}
