import 'package:app1/utilities/account_type.dart';
import 'package:app1/utilities/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app1/services/user_service.dart';
import 'package:app1/services/auth_service.dart';
import 'package:app1/services/boutique_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  BoutiqueService? _boutiqueService;

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      final response = await _userService.login({
        "email": email,
        "password": password,
      });

      if (response == null || response.statusCode != 200) {
        throw Exception("Login failed");
      }

      final token = response.data['token']['token'];
      SharedPreference.setAcessToken(token);
      // await _userService.setToken(token);
      debugPrint("token : $token");
      final profileResponse = await _userService.getUserProfile(email);
      if (profileResponse == null) throw Exception("Failed to get profile");

      final userData = profileResponse.data;
      final userId = userData['id'];

      final accountTypeInt = userData['accountType'] ?? 'customer';
      debugPrint('user type return => ${userData['accountType']}');
      final accountType = accountTypeInt == 'Seller' ? 'Seller' : 'Customer';

      SharedPreference.setUserId(userId.toString());
      SharedPreference.setUserRole(accountType.toString());
      // await _authService.saveUserId(userId.toString());
      // await _authService.saveUserRole(accountType);

      if (accountType == 'Seller') {
        _boutiqueService = BoutiqueService();
        bool hasBoutique = await _boutiqueService!.checkBoutiqueExists(userId);
        if (!hasBoutique) {
          SharedPreference.setUserRole("seller_needs_setup");

          //await _authService.saveUserRole('seller_needs_setup');
        }
      }

      return;
    } catch (e) {
      debugPrint("Login failed: $e");
      rethrow;
    }
  }

  Future<String?> getUserRole() async {
    try {
      return await _authService.getUserRole();
    } catch (e) {
      debugPrint("Failed to get saved user role: $e");
      return null;
    }
  }

  Future<bool> checkSellerHasBoutique() async {
    try {
      final userId = await _authService.getCurrentUserId();
      _boutiqueService = BoutiqueService();
      return await _boutiqueService!
          .checkBoutiqueExists(int.parse(userId) as String);
    } catch (e) {
      debugPrint("Boutique check failed: $e");
      return false;
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}
