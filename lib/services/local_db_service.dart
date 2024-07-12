import 'package:app1/models/UserModel.dart';
import 'package:app1/utilities/database.dart';

class localDbService {
  DatabaseNourProject databaseNourProject = DatabaseNourProject();
  // write the functions that will call the functions inside the database that will return the data

// database functions only returns raw data from the app database

// local service transforms data returned from the Database class and then returns it to the controller

  saveUser(UserModel model) async {
    return await databaseNourProject.insertUser("nomTable", model.dataMap());
  }

  readUser() async {
    return await databaseNourProject.readAllUsers("nomTable");
  }

  // another example
  readUserByName(firstname, lastname) async {
    return await databaseNourProject.readUserByName(firstname, lastname);
  }

  deleteUser(final id) async {
    return await databaseNourProject.deleteUser("NomTable", id);
  }

  updateUser(UserModel model) async {
    return await databaseNourProject.updateUser("NomTable", model.dataMap());
  }
}
