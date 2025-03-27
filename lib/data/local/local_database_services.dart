import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseServices {
  static const String _databaseName = "restaurant.db";
  static const String _tableName = "favorite";
  static const int _version = 1;

  Future<void> createTable(Database database) async {
    await database.execute("""
      CREATE TABLE $_tableName(
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      pictureId TEXT,
      city TEXT,
      rating REAL
      )
      """);
  }

  Future<Database> _initDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (database, version) async {
        await createTable(database);
      },
    );
  }

  Future<List<RestaurantListItem>> getAllItems() async {
    final db = await _initDb();
    final results = await db.query(_tableName);
    final restaurants =
        results.map((element) => RestaurantListItem.fromJson(element)).toList();

    return restaurants;
  }

  Future<int> insert(RestaurantListItem item) async {
    final db = await _initDb();

    final data = item.toJson();

    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<int> remove(String id) async {
    final db = await _initDb();
    final result = await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );

    return result;
  }
}
