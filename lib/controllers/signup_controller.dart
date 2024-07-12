import 'package:flutter/material.dart';

class SignupController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void signup(
      String username, String email, String password, String confirmPassword) {
    // signup logic here

    print('Signing up user with:');
    print('Username: $username');
    print('Email: $email');

    // For security reasons, do not print or store passwords in plain text.
    // Instead, you should hash or encrypt the password before sending it anywhere.
  }

  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    //add more
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
