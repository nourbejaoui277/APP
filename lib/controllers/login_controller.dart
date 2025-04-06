import 'package:flutter/material.dart';
import 'package:app1/services/user_service.dart';
import 'dart:convert';
import 'package:app1/services/auth_service.dart';

class LoginController {
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  Future<void> login(String email, String password) async {
    String? emailError = validateEmail(email);
    String? passwordError = validatePassword(password);

    if (emailError != null) {
      throw Exception(emailError);
    }
    if (passwordError != null) {
      throw Exception(passwordError);
    }

    try {
      final response = await _userService.login({
        "email": email,
        "password": password,
      });

      if (response != null) {
        print("Response Status Code: ${response.statusCode}");
        print("Response Data: ${response.data}");

        if (response.statusCode == 200) {
          final responseData = response.data;

          if (responseData.containsKey('token')) {
            final tokenObject = responseData['token'];

            if (tokenObject is Map<String, dynamic> &&
                tokenObject.containsKey('token')) {
              String token = tokenObject['token'];
              print("Login successful! Token: $token");
              String role = 'seller';
              await _authService.saveUserRole(role);
            } else {
              print("Error: Token not found in response");
              throw Exception("Token not found in response");
            }
          } else {
            print("Error: Token object not found in response");
            throw Exception("Token object not found in response");
          }
        } else if (response.statusCode == 401) {
          print("Error: Invalid email or password");
          throw Exception("Invalid email or password");
        } else {
          print("Error: ${response.statusMessage}");
          print("Error Details: ${response.data}");
          throw Exception("Login failed: ${response.statusMessage}");
        }
      } else {
        print("Response is null");
        throw Exception(
            " response : $response // ${response?.statusCode} // ${response?.data}");
      }
    } catch (e) {
      print("Login failed: $e");
      throw Exception("Login failed: $e");
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
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
