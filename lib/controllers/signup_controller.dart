import 'package:app1/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:app1/utilities/database.dart';
import 'package:app1/services/auth_service.dart';

class SignupController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final DatabaseNourProject _databaseNourProject = DatabaseNourProject();
  final AuthService _authService = AuthService();

  Future<void> signup(String username, String email, String password,
      String confirmPassword, String role) async {
    final validationErrors = {
      'username': validateUsername(username),
      'email': validateEmail(email),
      'password': validatePassword(password),
      'confirmPassword': validateConfirmPassword(password, confirmPassword),
    };

    final errorMessages =
        validationErrors.values.where((error) => error != null);
    if (errorMessages.isNotEmpty) {
      throw Exception(errorMessages.first);
    }

    try {
      final response = await UserService().createUser({
        'name': username,
        'email': email,
        'password': password,
        'role': role,
      });

      await _authService.saveUserRole(role);

      if (kDebugMode) {
        print('User signed up successfully:');
        print('Username: $username');
        print('Email: $email');
        print('Role: $role');
      }
    } catch (e) {
      final errorMessage = e.toString().contains('User already exists')
          ? "This email is already registered."
          : e.toString().contains('network')
              ? "Network error. Please check your connection."
              : "Signup failed. Please try again.";

      throw Exception(errorMessage);
    }
  }

  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    if (username.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
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
      return 'Please confirm your password';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
