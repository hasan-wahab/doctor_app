import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/app_keys/local_keys.dart';

class DBHelper {
  static Database? _db;

  // get database
  static Future<Database> getDb() async {
    if (_db != null) return _db!;

    _db = await initDb();
    return _db!;
  }

  // init database
  static Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'test.db');

    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  static Future _createTable(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${TableName.token}(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ${LocalKeys.token} TEXT
          )
        ''');

    await db.execute('''
    CREATE TABLE ${TableName.profile}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${LocalKeys.profile} TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE ${TableName.patientData}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${LocalKeys.patientKey} TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE ${TableName.allVisits}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${LocalKeys.allVisitKey} TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE ${TableName.allConsultantAssessment}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${LocalKeys.allConsultantAssessmentKey} TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE ${TableName.allTherapistSession}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${LocalKeys.allTherapistSessionKey} TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE ${TableName.allPackages}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${LocalKeys.allPackagesKey} TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE ${TableName.coverPhoto}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${LocalKeys.coverPhotoKey} TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE ${TableName.sliderImages}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${LocalKeys.sliderImagesKey} TEXT
    )
    ''');
  }
}
