import 'package:flutter/material.dart';
import 'package:app1/services/product_service.dart';

class ProductController {
  final ProductService _productService = ProductService();

  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      final response = await _productService.addProduct(productData);
      if (response != null && response.statusCode == 200) {
        print("Product added successfully!");
      } else {
        print("Failed to add product: ${response?.statusMessage}");
        throw Exception("Failed to add product");
      }
    } catch (e) {
      print(" Error adding product: $e");
      throw Exception("Error adding product: $e");
    }
  }

  Future<void> updateProduct(Map<String, dynamic> productData) async {
    try {
      final response = await _productService.updateProduct(productData);
      if (response != null && response.statusCode == 200) {
        print("Product updated successfully!");
      } else {
        print(" Failed to update product: ${response?.statusMessage}");
        throw Exception("Failed to update product");
      }
    } catch (e) {
      print("Error updating product: $e");
      throw Exception("Error updating product: $e");
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final response = await _productService.deleteProduct(id.toString());
      if (response != null && response.statusCode == 200) {
        print(" Product deleted successfully!");
      } else {
        print(" Failed to delete product: ${response?.statusMessage}");
        throw Exception("Failed to delete product");
      }
    } catch (e) {
      print("Error deleting product: $e");
      throw Exception("Error deleting product: $e");
    }
  }

  Future<Map<String, dynamic>> getProductById(int id) async {
    try {
      final response = await _productService.getProductById(id.toString());
      if (response != null && response.statusCode == 200) {
        return response.data;
      } else {
        print(" Failed to fetch product: ${response?.statusMessage}");
        throw Exception("Failed to fetch product");
      }
    } catch (e) {
      print("Error fetching product: $e");
      throw Exception("Error fetching product: $e");
    }
  }

  Future<List<dynamic>> getAllProducts() async {
    try {
      final response = await _productService.getAllProducts();
      if (response != null && response.statusCode == 200) {
        return response.data;
      } else {
        print("Failed to fetch products: ${response?.statusMessage}");
        throw Exception("Failed to fetch products");
      }
    } catch (e) {
      print(" Error fetching products: $e");
      throw Exception("Error fetching products: $e");
    }
  }

  Future<List<dynamic>> getProductsByPageAndLimit(int page, int limit) async {
    try {
      final response =
          await _productService.getProductsByPageAndLimit(page, limit);
      if (response != null && response.statusCode == 200) {
        return response.data;
      } else {
        print("Failed to fetch products: ${response?.statusMessage}");
        throw Exception("Failed to fetch products");
      }
    } catch (e) {
      print("Error fetching products: $e");
      throw Exception("Error fetching products: $e");
    }
  }
}
