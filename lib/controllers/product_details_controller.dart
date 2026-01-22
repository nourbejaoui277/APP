import 'package:flutter/material.dart';
import 'package:app1/models/product_details_model.dart';
import 'package:app1/services/product_details_service.dart';

class ProductDetailsController with ChangeNotifier {
  final ProductdetailsService productService;
  final Productdetails product;
  int quantity = 1;
  String message = '';
  int _userRating = 0;

  ProductDetailsController(
      {required this.productService, required this.product});

  int get userRating => _userRating;

  set userRating(int value) {
    _userRating = value;
    notifyListeners();
  }

  void incrementQuantity() {
    if (quantity < 10) {
      quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  Future<void> submitRating(double rating, BuildContext context) async {
    try {
      final success = await productService.submitRating(product.id, rating);
      message = success
          ? 'Rating submitted successfully!'
          : 'Failed to submit rating.';
    } catch (e) {
      message = 'Error submitting rating: $e';
    }
    notifyListeners();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
