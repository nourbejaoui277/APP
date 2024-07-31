import 'package:flutter/material.dart';
import 'package:app1/utilities/database.dart';

class LoginController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final DatabaseNourProject db = DatabaseNourProject();

  Future<bool> loginUser() async {
    String username = usernameController.text;
    String password = passwordController.text;
    var user = await db.loginUser(username, password);
    return user != null;
  }

  // validate username for login
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    // more validation rules as needed
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    // password length check
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
