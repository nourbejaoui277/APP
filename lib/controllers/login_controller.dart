import 'package:flutter/material.dart';

class LoginController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // Function to handle login process
  void login(String username, String password) {
    // Implement your login logic here

    // For example, you might call an API to authenticate the user
    print('Logging in user with:');
    print('Username: $username');
    // For security reasons, do not print or store passwords in plain text.
    // Instead, you should hash or encrypt the password before sending it anywhere.
  }

  // Function to validate username for login
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    // You can add more validation rules as needed
    return null; // Return null if validation succeeds
  }

  // Function to validate password for login
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    // Simple password length check
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null; // Return null if validation succeeds
  }
}
