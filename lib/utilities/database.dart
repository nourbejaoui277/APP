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
    String path = join(databasePath, "appDB");
    Database mydb =
        await openDatabase(path, onCreate: _onCreateDatabase, version: 1);
    //onUpgrade; _onUpgradingDatabase);
    return mydb;
  }

  _onCreateDatabase(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute(
        "CREATE TABLE nomTable ( id INTEGER PRIMARY KEY AUTOINCREMENT? ");
    await batch.commit();
  }

  //table a remplacer par le nom de table et data par les données a insérer
  insertUser(String table, data) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, data);
    return response;
  }

  readAllUsers(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

// another example
  readUserByName(firstname, lastname) async {
    Database? mydb = await db;
    var response = await mydb!.rawQuery(
        "SELECT * FROM ${"NomTable"} WHERE nom = ? AND prenom = ?",
        [lastname, firstname]);
    return response;
  }

  Future<int> deleteUser(nomTable, id) async {
    Database? mydb = await db;
    final res =
        await mydb!.rawDelete("DELETE FROM $nomTable WHERE id = ?", [id]);
    return res;
  }

  updateUser(String table, data) async {
    Database? mydb = await db;
    int response =
        await mydb!.update(table, data, where: 'id=?', whereArgs: [data['id']]);
    return response;
  }
}
