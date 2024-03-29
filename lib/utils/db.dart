import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE places (
            id TEXT PRIMARY KEY, 
            title TEXT, 
            image TEXT,
            lat REAL,
            lng REAL,
            address TEXT
          )''',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DB.database();

    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DB.database();

    return db.query(table);
  }
}
