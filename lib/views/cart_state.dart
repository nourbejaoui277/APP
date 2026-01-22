import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String price;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class CartState {
  static final List<CartItem> _cartItems = [];
  static final ValueNotifier<int> cartCount = ValueNotifier<int>(0);

  static List<CartItem> get items => _cartItems;

  static void addToCart(CartItem item) {
    final existingItem = _cartItems.firstWhere(
      (cartItem) => cartItem.name == item.name,
      orElse: () => item,
    );
    if (existingItem == item) {
      _cartItems.add(item);
    } else {
      existingItem.quantity++;
    }
    cartCount.value = _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  static void removeFromCart(CartItem item) {
    final existingItem =
        _cartItems.firstWhere((cartItem) => cartItem.name == item.name);
    if (existingItem.quantity > 1) {
      existingItem.quantity--;
    } else {
      _cartItems.removeWhere((cartItem) => cartItem.name == item.name);
    }
    cartCount.value = _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  static void clearCart() {
    _cartItems.clear();
    cartCount.value = 0;
  }
}
