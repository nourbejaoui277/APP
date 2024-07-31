import 'package:app1/models/UserModel.dart';
import 'package:app1/utilities/database.dart';

class LocalDbService {
  DatabaseNourProject databaseNourProject = DatabaseNourProject();

  // Write the functions that will call the functions inside the database that will return the data
  // Database functions only return raw data from the app database
  // Local service transforms data returned from the Database class and then returns it to the controller

  Future<int> saveUser(UserModel model) async {
    return await databaseNourProject.registerUser(model.dataMap());
  }

  Future<List<Map<String, dynamic>>> readAllUsers() async {
    return await databaseNourProject.readAllUsers();
  }

  Future<List<Map<String, dynamic>>> readUserByName(
      String firstname, String lastname) async {
    // Adjusted to match the column names in the database schema
    return await databaseNourProject.readUserByName(firstname, lastname);
  }

  Future<int> deleteUser(int id) async {
    return await databaseNourProject.deleteUser(id);
  }

  Future<int> updateUser(UserModel model) async {
    return await databaseNourProject.updateUser(model.dataMap());
  }

  Future<Map<String, dynamic>?> loginUser(
      String username, String password) async {
    return await databaseNourProject.loginUser(username, password);
  }
}
