import 'package:app1/models/search_filter.dart';
import 'package:app1/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';
import 'package:app1/models/order_model.dart' as prod;

class ProductService {
  final String baseUrl = 'http://10.0.2.2:5267/api/Product';
  final String token = SharedPreference.getAccessToken()!;

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/GetAllProducts'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      debugPrint("$baseUrl/AddProduct");
      debugPrint("data : ${product.toJson()}");
      final response = await http.post(
        Uri.parse('$baseUrl/AddProduct'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token'
        },
        body: jsonEncode(product.toJson()),
      );
      debugPrint("response : $response");
    } catch (ex) {
      debugPrint("exception addProduct : ${ex.toString()}");
    }
    // if (response.statusCode != 200) {
    //   throw Exception('Failed to add product');
    // }
  }

  Future<void> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/UpdateProduct'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      },
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/DeleteProduct/$id'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token'
        });
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }

  Future<List<prod.Product>> searchProduct(SearchFilters filters) async {
    final response = await http.post(
      Uri.parse('$baseUrl/GetByFilters'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: jsonEncode(filters.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to search products: ${response.statusCode} ${response.reasonPhrase}',
      );
    }

    // Decode and cast to List<dynamic> safely
    final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;

    return jsonList
        .map((e) => prod.Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
