import 'package:flutter/material.dart';
import 'package:app1/models/order_model.dart';

class ProfileController extends ChangeNotifier {
  String name = 'John Doe';
  String email = 'john.doe@example.com';
  String phone = '+1234567890';

  List<Order> orders = [];

  ProfileController() {
    fetchOrders();
  }

  void fetchOrders() {
    orders = [
      Order(
        id: '12345',
        date: DateTime(2024, 6, 12),
        items: ['Item 1', 'Item 2'],
        totalAmount: 50.0,
        status: 'Delivered',
      ),
      Order(
        id: '12346',
        date: DateTime(2024, 6, 15),
        items: ['Item 3', 'Item 4'],
        totalAmount: 75.0,
        status: 'Shipped',
      ),
    ];
    notifyListeners();
  }

  void updateProfile(String text, String text2, String text3) {}
}
