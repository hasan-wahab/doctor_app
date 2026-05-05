import 'dart:convert';

import 'package:doctor_app/core/app_keys/local_keys.dart';
import 'package:doctor_app/data/local_storage/local_curd_base/local_curd_base.dart';

import '../../data/models/all_packages_model.dart';

class AllPackagesLocalRepo {
  LocalCurdBase localCurdBase;
  AllPackagesLocalRepo({required this.localCurdBase});

  Future saveAllPackagesFromLocal({required AllPackagesModel model}) async {
    await localCurdBase.saveData(
      tableName: TableName.allPackages,
      key: LocalKeys.allPackagesKey,
      data: model.toJson(),
    );
  }

  Future<AllPackagesModel> getAllPackagesFromLocal() async {
    var result = await localCurdBase.getData(tableName: TableName.allPackages);

    if (result.isEmpty) {
      print('All Packages Empty');
      return AllPackagesModel.fromJson([]);
    }

    var parseString = result.first[LocalKeys.allPackagesKey];
    if (parseString == null) {
      print('All Packages key null');
      return AllPackagesModel.fromJson([]);
    }
    return AllPackagesModel.fromJson(jsonDecode(parseString as String));
  }

  Future deleteAllPackages() async {
    await localCurdBase.deleteData(tableName: TableName.allPackages);
  }
}
