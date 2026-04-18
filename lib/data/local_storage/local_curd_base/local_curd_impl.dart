import 'dart:convert';

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
    required Map<String, dynamic> data,
  }) async {
    try {
      final db = await DBHelper.getDb();

      await db.insert(tableName, {key: jsonEncode(data)});
    } catch (e) {
      throw BaseExceptions(message: e.toString(), debugMessage: e.toString());
    }
  }

  @override
  Future<List<Map<String, Object?>>> getData({
    required String tableName,
  }) async {
    try {
      final db = await DBHelper.getDb();

      final result = await db.query(tableName);
      return result;
    } catch (e) {
      if (kDebugMode) {
        print("Curd Impl Error: $e");
      }
      throw BaseExceptions(message: e.toString(), debugMessage: e.toString());
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

      await db.delete(tableName);
    } catch (e) {
      throw BaseExceptions(message: e.toString(), debugMessage: e.toString());
    }
  }
}
