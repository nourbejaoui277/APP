import 'dart:convert';
import 'package:app1/utilities/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserService {
  final dio = Dio();
  final path = "http://10.0.2.2:5267/api";

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<Response?> login(data) async {
    try {
      debugPrint("Sending login request: ${jsonEncode(data)}");
      final response = await dio.post(
        '$path/User/login',
        data: jsonEncode(data),
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        final token = response.data['token']['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        debugPrint("Token saved: $token");
      }

      return response;
    } catch (e) {
      debugPrint("Login error: ${e.toString()}");
      debugPrint("result data : $Response");
      //throw Exception("exception : ${e.toString()}");
    }
  }

  Future<Response?> getUserProfile(String email) async {
    try {
      final String token = SharedPreference.getAccessToken()!;
      final response = await dio.post(
        '$path/User/GetUserProfile/GetUserProfile',
        data: jsonEncode(email),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      debugPrint("Profile response: ${response.data}");
      return response;
    } catch (e) {
      debugPrint("Error getting profile: $e");
      return null;
    }
  }
  // Future<Response?> login(Map<String, dynamic> data) async {
  //   try {
  //     debugPrint("Sending login request: $data");
  //     final response = await http.post(Uri.parse('$path/User/login'),
  //         body: jsonEncode(data),
  //         headers: {"Content-Type": "application/json"});

  //     if (response.statusCode == 200) {
  //       final token = (jsonDecode(response.body))['token'];
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       await prefs.setString('token', token);
  //       debugPrint("Token saved: $token");
  //     }

  //     return jsonDecode(response.body);
  //   } catch (e) {
  //     debugPrint("Login error: ${e.toString()}");
  //     return null;
  //   }
  // }

  Future<Response?> createUser(Map<String, dynamic> data) async {
    try {
      final accountType = data['role'] == 'seller' ? 1 : 0;

      final requestData = {
        'name': data['name'],
        'email': data['email'],
        'password': data['password'],
        'accountType': accountType,
      };

      debugPrint("Creating user with data: $requestData");

      final response = await dio.post(
        '$path/User/CreateUser/createUser',
        data: jsonEncode(requestData),
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return response;
      } else {
        // Parse error message from backend
        final errorMsg = response.data['message'] ?? 'Signup failed';
        throw Exception(errorMsg);
      }
    } on DioException catch (e) {
      debugPrint("Dio error: ${e.toString()}");
      if (e.response != null) {
        final errorMsg = e.response?.data['message'] ?? 'Signup failed';
        throw Exception(errorMsg);
      }
      throw Exception("Network error. Please try again.");
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      throw Exception("An unexpected error occurred");
    }
  }
}
