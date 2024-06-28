import 'package:flutter/material.dart';

class SignupController {
  // Function to handle signup process
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  void signup(
      String username, String email, String password, String confirmpassword) {
    // Implement your signup logic here

    // For example, you might call an API to register the user
    print('Signing up user with:');
    print('Username: $username');
    print('Email: $email');

    // For security reasons, do not print or store passwords in plain text.
    // Instead, you should hash or encrypt the password before sending it anywhere.
  }

  // Function to validate username for signup
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    // You can add more validation rules as needed
    return null; // Return null if validation succeeds
  }

  // Function to validate email for signup
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    // Simple email validation check
    if (!email.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null; // Return null if validation succeeds
  }

  // Function to validate password for signup
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    // Simple password length check
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    // Function to validate  confirm password for signup
    String? validateconfirmPassword(String? confirmpassword) {
      if (confirmpassword != password ||
          confirmpassword == null ||
          confirmpassword.isEmpty) {
        return 'Password & Confirm Password do not match';
      }
      return null; // Return null if validation succeeds
    }
  }
}
