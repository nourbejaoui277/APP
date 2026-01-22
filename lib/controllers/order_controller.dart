import 'package:flutter/material.dart';
import 'package:app1/models/order_model.dart';
import 'package:app1/services/order_service.dart';

class OrdersController extends ChangeNotifier {
  final OrderService orderService;
  final String boutiqueId;

  OrdersController({required this.orderService, required this.boutiqueId});

  List<Order> _orders = [];
  bool isLoading = false;
  String selectedStatus = 'All';

  List<Order> get filteredOrders {
    if (selectedStatus == 'All') return _orders;
    return _orders.where((order) => order.status == selectedStatus).toList();
  }

  Future<void> fetchOrders() async {
    isLoading = true;
    notifyListeners();
    try {
      _orders = await orderService.fetchOrders(boutiqueId);
    } catch (e) {
      debugPrint('Error fetching orders: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  void setSelectedStatus(String status) {
    selectedStatus = status;
    notifyListeners();
  }
}
