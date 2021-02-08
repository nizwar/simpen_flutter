import 'package:flutter/material.dart';
import 'package:simpen_simpen/core/resources/environment.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseEngine {
  final Database shared;
  final BuildContext context;

  DatabaseEngine(this.context, this.shared);

  static Future<DatabaseEngine> initialized(BuildContext context) async => DatabaseEngine(context, await initDB());

  static Future<Database> initDB() async => openDatabase(
        (await getDatabasesPath()) + "/simpenan.sql",
        onCreate: (db, version) {
          db.execute("""
              CREATE TABLE simpenan(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT,
                type INTEGER(1),
                category TEXT,
                amount INTEGER(11)
              );
              """);
        },
        version: sqliteVersion,
      );
}
