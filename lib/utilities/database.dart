// write functions that will retrieve data from the database
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseNourProject {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializeDb();
      return _db;
    } else {
      return _db;
    }
  }

  initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "appDB.db");
    Database mydb = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDatabase,
      // onUpgrade: _onUpgradingDatabase, // Uncomment if you need an upgrade function
    );
    return mydb;
  }

  _onCreateDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE nomTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT,
        prenom TEXT,
        username TEXT,
        password TEXT,
        email TEXT
      )
    ''');
  }

  // Replace table with the actual table name and data with the data to insert
  Future<int> insertUser(String table, Map<String, dynamic> data) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, data);
    return response;
  }

  Future<List<Map<String, dynamic>>> readAllUsers(String table) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(table);
    return response;
  }

  // Example to read user by name
  Future<List<Map<String, dynamic>>> readUserByName(
      String firstname, String lastname) async {
    Database? mydb = await db;
    var response = await mydb!.rawQuery(
        "SELECT * FROM nomTable WHERE nom = ? AND prenom = ?",
        [lastname, firstname]);
    return response;
  }

  Future<int> deleteUser(String table, int id) async {
    Database? mydb = await db;
    final res = await mydb!.rawDelete("DELETE FROM $table WHERE id = ?", [id]);
    return res;
  }

  Future<int> updateUser(String table, Map<String, dynamic> data) async {
    Database? mydb = await db;
    int response =
        await mydb!.update(table, data, where: 'id=?', whereArgs: [data['id']]);
    return response;
  }
}
