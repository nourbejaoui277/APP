import 'dart:convert';
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
      debugPrint("Creating user with data: $data");
      final response = await dio.post(
        '$path/User/createUser',
        data: jsonEncode(data),
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Data: ${response.data}");

      return response;
    } catch (e) {
      debugPrint("Dio error: ${e.toString()}");
      return null;
    }
  }
}
