import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/promotion.dart';

class PromotionService {
  final String baseUrl = 'http://10.0.2.2:5267/api/Promotion';

  Future<List<Promotion>> fetchPromotions() async {
    final response = await http.get(Uri.parse('$baseUrl/GetAllPromotions'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      debugPrint(" data value : $data");
      if (data != []) {
        var res = data.map((json) => Promotion.fromJson(json)).toList();
        debugPrint(" res value : ${jsonEncode(res)}");
        return res;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load promotions');
    }
  }

  Future<void> addPromotion(Promotion promotion) async {
    final response = await http.post(
      Uri.parse('$baseUrl/AddPromotion'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(promotion.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add promotion');
    }
  }

  Future<void> updatePromotion(Promotion promotion) async {
    final response = await http.put(
      Uri.parse('$baseUrl/UpdatePromotion'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(promotion.toJsonUpdate()),
    );
    debugPrint(
        "response val :  ${response.statusCode}  ////// ${jsonDecode(response.body)}");
    if (response.statusCode != 200) {
      throw Exception('Failed to update promotion');
    }
  }

  Future<void> deletePromotion(String id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/DeletePromotion/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete promotion');
    }
  }
}
