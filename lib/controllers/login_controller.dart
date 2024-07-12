import 'package:flutter/material.dart';

class LoginController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String username, String password) {
    // login logic here

    print('Logging in user with:');
    print('Username: $username');
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
    //password length check
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
