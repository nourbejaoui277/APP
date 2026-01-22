import 'dart:convert';
import 'package:app1/views/seller/seller_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app1/models/seller_settings_model.dart';
import '../models/boutique.dart';
import '../utilities/shared_preferences.dart';

class SellerSettingsService {
  final String baseUrl = 'http://10.0.2.2:5267/api';
  final String token = SharedPreference.getAccessToken()!;

  Future<SellerSettingsModel> fetchsellersettings(String userId) async {
    userId = "08dd899d-f422-4593-8583-18fb7619d8a5";
    final response = await http.get(
      Uri.parse('$baseUrl/Boutique/GetByUser/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
    );
    debugPrint(
        "response seller settings :  ${response.statusCode} ////     ${jsonDecode(response.body)}");
    if (response.statusCode == 200) {
      return SellerSettingsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<Boutique> fetchBoutique(String boutiqueId) async {
    boutiqueId = 11.toString();
    final response = await http.get(
      Uri.parse('$baseUrl/Boutique/$boutiqueId'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
    );
    debugPrint(
        "response boutique :  ${response.statusCode} ////     ${jsonDecode(response.body)}");
    if (response.statusCode == 200) {
      return Boutique.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load boutique');
    }
  }

  Future<void> updateBoutique(Boutique boutique) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Boutique'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
      body: jsonEncode(boutique.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update boutique');
    }
  }
}
