import 'package:flutter/material.dart';
import 'package:simpen_simpen/core/models/simpenanDB.dart';
import 'package:simpen_simpen/core/providers/databaseProvider.dart';
import 'package:simpen_simpen/core/utils/databaseEngine.dart';
import 'package:sqflite_common/sqlite_api.dart';

class SimpenanDB extends DatabaseEngine {
  static String tableName = "simpenan";
  SimpenanDB(BuildContext context, Database shared) : super(context, shared);

  Future insert(Simpenan value) async {
    await shared.insert(tableName, value.toJson());
    DatabaseProvider.instance(context).notify();
  }

  Future update(int id, Simpenan value) async {
    await shared.update(
        tableName,
        value.toJson()
          ..removeWhere((key, value) {
            return key == "id";
          }),
        where: "id = ?",
        whereArgs: [id]);
    DatabaseProvider.instance(context).notify();
  }

  Future delete(int id) async {
    await shared.delete(tableName, where: "id = ?", whereArgs: [id]);
    DatabaseProvider.instance(context).notify();
  }

  Future<List<Simpenan>> getAll() {
    return shared.query(tableName).then((value) => value.map((item) => Simpenan.fromJson(item)).toList());
  }

  Future<Simpenan> getById(int id) {
    return shared.query(tableName, where: "id = ?", whereArgs: [id]).then((value) => value.length > 0 ? Simpenan.fromJson(value.first) : null);
  }

  Future<int> totalIncome() {
    return shared.query(tableName, where: "type = ?", whereArgs: [0]).then((value) => value.length == 0 ? 0 : value.map((item) => Simpenan.fromJson(item).amount).toList().reduce((a, b) => a + b));
  }

  Future<int> totalOutcome() {
    return shared.query(tableName, where: "type = ?", whereArgs: [1]).then((value) => value.length == 0 ? 0 : value.map((item) => Simpenan.fromJson(item).amount).toList().reduce((a, b) => a + b));
  }
}
