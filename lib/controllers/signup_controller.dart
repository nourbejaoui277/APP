import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for utf8.encode
import 'package:app1/utilities/database.dart';

class SignupController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final DatabaseNourProject _databaseNourProject = DatabaseNourProject();

  Future<void> signup(String username, String email, String password,
      String confirmPassword) async {
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

    // Hash the password before storing it
    var bytes = utf8.encode(password);
    var hashedPassword = sha256.convert(bytes).toString();

    // Insert the user into the database
    await _databaseNourProject.insert('users', {
      'username': username,
      'email': email,
      'password': hashedPassword,
    });

    print('Signing up user with:');
    print('Username: $username');
    print('Email: $email');
  }

  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    // add more validation rules as needed
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    // email validation check
    if (!email.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    // Simple password length check
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Function to validate confirm password for signup
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
