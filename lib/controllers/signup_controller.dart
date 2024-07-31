import 'package:flutter/material.dart';
import 'package:app1/utilities/database.dart';

class SignupController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final DatabaseNourProject _databaseNourProject = DatabaseNourProject();

  Future<void> signup() async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    String? usernameError = validateUsername(username);
    String? emailError = validateEmail(email);
    String? passwordError = validatePassword(password);
    String? confirmPasswordError =
        validateConfirmPassword(password, confirmPassword);

    if (usernameError != null) {
      throw Exception(usernameError);
    }
    if (emailError != null) {
      throw Exception(emailError);
    }
    if (passwordError != null) {
      throw Exception(passwordError);
    }
    if (confirmPasswordError != null) {
      throw Exception(confirmPasswordError);
    }

    // Create user data map
    Map<String, dynamic> userData = {
      'username': username,
      'email': email,
      'password': password, // Ensure you hash the password in a real app
    };
    debugPrint("userDAta : $userData");
    debugPrint("userDAta username : ${userData['username']}");
    // Insert user data into the database
    int result = await _databaseNourProject.insert('users', userData);
    if (result == 0) {
      throw Exception('Failed to register user');
    }
  }

  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    // Add more validation rules if needed
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!email.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }
    if (confirmPassword != password) {
      return 'Password and Confirm Password do not match';
    }
    return null;
  }
}
