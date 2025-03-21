import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  final dio = Dio();
  final path = "http://10.0.2.2:5267/api";

  // Retrieve Token from SharedPreferences
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Add Authorization Header
  Future<Map<String, dynamic>> _getHeaders() async {
    String? token = await _getToken();
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Future<Response?> addProduct(Map<String, dynamic> data) async {
    try {
      debugPrint("Adding product: $data");
      final headers = await _getHeaders();
      final response = await dio.post(
        '$path/Product/AddProduct',
        data: jsonEncode(data),
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      debugPrint("Add product error: ${e.toString()}");
      return null;
    }
  }

  Future<Response?> updateProduct(Map<String, dynamic> data) async {
    try {
      debugPrint("Updating product: $data");
      final headers = await _getHeaders();
      final response = await dio.put(
        '$path/Product/UpdateProduct',
        data: jsonEncode(data),
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      debugPrint("Update product error: ${e.toString()}");
      return null;
    }
  }

  Future<Response?> deleteProduct(String id) async {
    try {
      debugPrint("Deleting product with ID: $id");
      final headers = await _getHeaders();
      final response = await dio.delete(
        '$path/Product/DeleteProduct/$id',
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      debugPrint("Delete product error: ${e.toString()}");
      return null;
    }
  }

  Future<Response?> getProductById(String id) async {
    try {
      debugPrint("Fetching product with ID: $id");
      final headers = await _getHeaders();
      final response = await dio.get(
        '$path/Product/GetProductById/$id',
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      debugPrint("Get product by ID error: ${e.toString()}");
      return null;
    }
  }

  Future<Response?> getAllProducts() async {
    try {
      debugPrint("Fetching all products");
      final headers = await _getHeaders();
      final response = await dio.get(
        '$path/Product/GetAllProducts',
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      debugPrint("Get all products error: ${e.toString()}");
      return null;
    }
  }

  Future<Response?> getProductsByPageAndLimit(int page, int limit) async {
    try {
      debugPrint("Fetching products - Page: $page, Limit: $limit");
      final headers = await _getHeaders();
      final response = await dio.get(
        '$path/Product/GetProductByPageandLimit?page=$page&limit=$limit',
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      debugPrint("Get products by page error: ${e.toString()}");
      return null;
    }
  }
}
