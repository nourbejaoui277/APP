import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseNourProject {
  static final DatabaseNourProject _instance = DatabaseNourProject._internal();
  static Database? _db;

  factory DatabaseNourProject() {
    return _instance;
  }

  DatabaseNourProject._internal();

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initializeDb();
    }
    return _db;
  }

  Future<Database> _initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "appDB.db");
    Database mydb = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDatabase,
      onUpgrade: _onUpgradingDatabase,
    );
    return mydb;
  }

  Future<void> _onCreateDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        username TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE store (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        storeId INTEGER,
        productId INTEGER,
        status TEXT,
        FOREIGN KEY(productId) REFERENCES product(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE product (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER,
        status TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        orderDate TEXT,
        status TEXT,
        totalAmount REAL,
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');
  }

  Future<void> _onUpgradingDatabase(
      Database db, int oldVersion, int newVersion) async {}

  Future<int> insert(String table, Map<String, dynamic> data) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, data);
    return response;
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(table);
    return response.isNotEmpty ? response : [];
  }

  Future<List<Map<String, dynamic>>> queryBy(
      String table, String column, dynamic value) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response =
        await mydb!.query(table, where: '$column = ?', whereArgs: [value]);
    return response.isNotEmpty ? response : [];
  }

  Future<int> delete(String table, int id) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: 'id = ?', whereArgs: [id]);
    return response;
  }

  Future<int> update(String table, Map<String, dynamic> data, int id) async {
    Database? mydb = await db;
    int response =
        await mydb!.update(table, data, where: 'id = ?', whereArgs: [id]);
    return response;
  }

  Future<void> close() async {
    Database? mydb = await db;
    await mydb!.close();
  }

  Future<int> registerUser(Map<String, dynamic> userData) async {
    Database? mydb = await db;
    int response = await mydb!.insert('users', userData);
    return response;
  }

  Future<Map<String, dynamic>?> loginUser(
      String username, String password) async {
    debugPrint("username : $username");
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (response.isNotEmpty) {
      return response.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> readAllUsers() async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query('users');
    return response.isNotEmpty ? response : [];
  }

  Future<List<Map<String, dynamic>>> readUserByName(
      String firstname, String lastname) async {
    Database? mydb = await db;
    var response = await mydb!.rawQuery(
        "SELECT * FROM users WHERE name = ? AND username = ?",
        [lastname, firstname]);
    return response.isNotEmpty ? response : [];
  }

  Future<int> deleteUser(int id) async {
    Database? mydb = await db;
    final res = await mydb!.rawDelete("DELETE FROM users WHERE id = ?", [id]);
    return res;
  }

  Future<int> updateUser(Map<String, dynamic> data) async {
    Database? mydb = await db;
    int response = await mydb!
        .update('users', data, where: 'id=?', whereArgs: [data['id']]);
    return response;
  }
}
