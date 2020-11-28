import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath = await sql.getDatabasesPath();

    final sqlDb = await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);

    await sqlDb.insert(table, data);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final dbPath = await sql.getDatabasesPath();

    final sqlDb = await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);

    return await sqlDb.query(table);
  }
}
