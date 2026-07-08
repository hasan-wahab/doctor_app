import 'dart:convert';

import 'package:doctor_app/core/app_keys/local_keys.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';
import 'package:doctor_app/data/models/slider_model.dart';

class SliderImagesLocalRepo {
  LocalCurdBase localCurdBase;

  SliderImagesLocalRepo({required this.localCurdBase});
  Future saveSliderImages({required List<SliderModel> model}) async {
    final modelData = model.map((e) => e.toJson()).toList();
    await localCurdBase.saveData(
      tableName: TableName.sliderImages,
      key: LocalKeys.sliderImagesKey,
      data: modelData,
    );
  }

  Future<List<SliderModel>> getSliderImages() async {
    final result = await localCurdBase.getData(
      tableName: TableName.sliderImages,
    );

    if (result.isEmpty) {
      print('No data found in local');
      return [];
    }

    var jsonParsing = result.first[LocalKeys.sliderImagesKey];

    if (jsonParsing == null) {
      print('Data null');
      return [];
    }

    // ✅ Case: already List<Map>
    if (jsonParsing is List) {
      return List<SliderModel>.from(
        jsonParsing.map((e) => SliderModel.fromJson(e)),
      );
    }

    // ✅ Case: String (fallback)
    if (jsonParsing is String) {
      final decoded = jsonDecode(jsonParsing);

      return List<SliderModel>.from(
        decoded.map((e) => SliderModel.fromJson(e)),
      );
    }

    return [];
  }

  Future deleteSliderImages() {
    return localCurdBase.deleteData(tableName: TableName.sliderImages);
  }
}
