import 'dart:convert';

import 'package:doctor_app/core/app_exceptions/app_exceptions.dart';
import 'package:doctor_app/core/app_exceptions/base_exceptions.dart';
import 'package:doctor_app/data/local_storage/local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/app_keys/local_keys.dart';
import '../local_db.dart';
import 'local_curd_base.dart';

class LocalCurdImpl implements LocalCurdBase {
  @override
  Future saveData({
    required String tableName,
    required String key,
    required data,
  }) async {
    try {
      final db = await DBHelper.getDb();

      await db.insert(tableName, {key: jsonEncode(data)});
    } catch (e) {
      throw AppExceptions(
        message: 'Save Data Error in Local Curd Impl',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<List<Map<String, Object?>>> getData({
    required String tableName,
  }) async {
    try {
      final db = await DBHelper.getDb();

      final result = await db.query(tableName);
      print(result);
      return result;
    } catch (e) {
      throw AppExceptions(
        message: 'Get Data Error in Local Curd Impl',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future updateData({required String key, required Map<String, dynamic> data}) {
    // TODO: implement updateData
    throw UnimplementedError();
  }

  @override
  Future deleteData({required String tableName}) async {
    try {
      final db = await DBHelper.getDb();

      await db.delete(tableName).then((_) {
        print('Delete $tableName');
      });
    } catch (e) {
      throw AppExceptions(
        message: 'Delete Data Error in Local Curd Impl',
        debugMessage: e.toString(),
      );
    }
  }



}
