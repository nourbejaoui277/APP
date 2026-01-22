import 'dart:convert';
import 'package:app1/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/order_model.dart';

class OrderService {
  final String baseUrl = 'http://10.0.2.2:5267/api/Order';
  final String? token = SharedPreference.getAccessToken();

  Future<List<Order>> fetchOrders(String boutiqueId) async {
    debugPrint("boutique id : $boutiqueId");
    boutiqueId = 11.toString();
    final response = await http.get(
      Uri.parse('$baseUrl/$boutiqueId'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
    );
    debugPrint("response orders: ${jsonDecode(response.body)}");
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      var res = data.map((json) => Order.fromJson(json)).toList();
      debugPrint("res values : $res");
      return res;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> checkoutOrder(Map<String, dynamic> orderData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/checkout'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
      body: jsonEncode(orderData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to place order');
    }
  }
}
