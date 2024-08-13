import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for utf8.encode
import 'package:app1/utilities/database.dart';

class LoginController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final DatabaseNourProject _databaseNourProject = DatabaseNourProject();

  Future<void> login(String username, String password) async {
    String? usernameError = validateUsername(username);
    String? passwordError = validatePassword(password);

    if (usernameError != null) {
      throw Exception(usernameError);
    }
    if (passwordError != null) {
      throw Exception(passwordError);
    }

    // Fetch the stored user data
    List<Map<String, dynamic>> result = await _databaseNourProject.queryBy(
      'users',
      'username',
      username,
    );

    if (result.isEmpty) {
      throw Exception('User not found');
    }

    // Compare the stored hash with the hash of the entered password
    var bytes = utf8.encode(password);
    var hashedPassword = sha256.convert(bytes).toString();
    if (result[0]['password'] != hashedPassword) {
      throw Exception('Invalid username or password');
    }

    // Successfully logged in
    print('Logging in user with:');
    print('Username: $username');
  }

  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    return null;
  }
}
