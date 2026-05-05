import 'dart:convert';

import 'package:doctor_app/core/app_keys/local_keys.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/models/slider_model.dart';

class SliderImagesLocalRepo {
  LocalCurdBase localCurdBase;

  SliderImagesLocalRepo({required this.localCurdBase});
  Future saveSliderImages({required SliderModel model}) async {
    await localCurdBase.saveData(
      tableName: TableName.sliderImages,
      key: LocalKeys.sliderImagesKey,
      data: model.toJson(),
    );
  }

  Future<SliderModel> getSliderImages() async {
    SliderModel model;
    final result = await localCurdBase.getData(
      tableName: TableName.sliderImages,
    );

    if (result.isEmpty) {
      print('No data found in local');
      return SliderModel.fromJson({});
    }
    var jsonParsing = result.first[LocalKeys.sliderImagesKey];

    if (jsonParsing == null) {
      print('Patient null');
      return SliderModel.fromJson({});
    }
    model = SliderModel.fromJson(jsonDecode(jsonParsing as String));
    print(model.message);
    return model;
  }

  Future deleteSliderImages() {
    return localCurdBase.deleteData(tableName: TableName.sliderImages);
  }
}
