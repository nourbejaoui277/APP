
// write functions that will retrieve data from the database
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
class DatabaseNourProject{
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializeDb();
      return _db;
    }else{
      return _db;
    }
  }
  initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "appDB");
    Database mydb= await openDatabase(path, onCreate: _onCreateDatabase, version: 1);
    //onUpgrade; _onUpgradingDatabase);
    return mydb;
  }

  _onCreateDatabase(Database db, int version) async{
    Batch batch = db.batch();
    batch.execute(
      "CREATE TABLE nomTable ( id INTEGER PRIMARY KEY AUTOINCREMENT? "
    );
    await batch.commit();
  }
}
