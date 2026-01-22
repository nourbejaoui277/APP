import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductController extends ChangeNotifier {
  final ProductService _service = ProductService();
  List<Product> products = [];
  bool isLoading = false;

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();
    try {
      products = await _service.fetchProducts();
    } catch (e) {
      debugPrint('Error loading products: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _service.addProduct(product);
      await loadProducts();
    } catch (e) {
      debugPrint('Error adding product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _service.updateProduct(product);
      await loadProducts();
    } catch (e) {
      debugPrint('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _service.deleteProduct(id);
      await loadProducts();
    } catch (e) {
      debugPrint('Error deleting product: $e');
    }
  }

  List<Product> filterProducts({
    required int sectionId,
    String? subcategory,
    required RangeValues priceRange,
    int? boutiqueId,
    required String searchQuery,
    required Map<String, int> subcategories,
  }) {
    // Temporary fallback – just return all products for now
    return products;
  }
}
