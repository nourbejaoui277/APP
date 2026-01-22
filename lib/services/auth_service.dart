import 'package:app1/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveUserRole(String role) async {
    await _storage.write(key: 'user_role', value: role);
    debugPrint("Saved user role: $role");
  }

  Future<String?> getUserRole() async {
    final role = SharedPreference.getUserRole();
    //await _storage.read(key: 'user_role');
    //debugPrint("Read user role: $role");
    return role;
  }

  Future<void> clearUserRole() async {
    await _storage.delete(key: 'user_role');
    debugPrint("Cleared user role");
  }

  Future<bool> isSeller() async {
    String? role = await getUserRole();
    return role == 'seller' || role == 'seller_needs_setup';
  }

  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
    debugPrint("Saved user ID: $userId");
  }

  Future<String> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id') ?? '';
    debugPrint("Read user ID: $userId");
    return userId;
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    debugPrint("Cleared all storage");
  }

  Future<void> logout() async {
    await clearAll();
  }
}
