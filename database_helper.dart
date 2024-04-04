import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'users.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      fname Text,
      lname Text,
      age int ,
      gender Text
    )
    """);
  }

  static Future<String?> createItems(
      String? fname, String? lname, int? age, String? gender) async {
    final db = await DatabaseHelper.db();
    final data = {'fname': fname, 'lname': lname, 'age': age, 'gender': gender};
    int count = 0;
    // count =
    //     Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM items'))!;

    // ignore: unused_local_variable
    var r = getItem2(fname.toString());

    var res = await db.query('items', where: 'fname=?', whereArgs: [fname]);
    if (res.isEmpty) {
      final id = await db.insert('items', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      return "TEST";
    } else {
      return "FAIL";
    }

    // final id = await db.insert('items', data,
    //     conflictAlgorithm: sql.ConflictAlgorithm.replace);
    // return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseHelper.db();
    return db.query('items', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('items', where: 'id=?', whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getItem2(String id) async {
    final db = await DatabaseHelper.db();
    return db.query('items', where: 'fname=?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, String fname, String? lname, int? age, String? gender) async {
    final db = await DatabaseHelper.db();

    final data = {'fname': fname, 'lname': lname, 'age': age, 'gender': gender};

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<int?> getcount(id) async {
    final db = await DatabaseHelper.db();
    int count = 0;
    count = Sqflite.firstIntValue(
        await db.rawQuery('select count(*) from items where fname=fname'))!;
    return count;
  }
}
