import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardService {
  final String baseUrl = 'http://10.0.2.2:5267/api';
  final String token;

  DashboardService(this.token);

  Future<double> getTotalSales(int boutiqueId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Order/GetTotalSales/$boutiqueId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['totalSales']?.toDouble() ?? 0.0;
    } else {
      throw Exception('Failed to load total sales');
    }
  }

  Future<List<dynamic>> getPendingOrders(int boutiqueId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Order/GetOrdersByBoutique/$boutiqueId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      List<dynamic> orders = jsonDecode(response.body);
      return orders.where((order) => order['status'] == 'Pending').toList();
    } else {
      throw Exception('Failed to load pending orders');
    }
  }

  Future<List<dynamic>> getLowStockProducts(int boutiqueId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Product/GetProductsByBoutique/$boutiqueId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      List<dynamic> products = jsonDecode(response.body);
      return products.where((p) => p['quantity'] < 5).toList();
    } else {
      throw Exception('Failed to load low stock products');
    }
  }

  Future<double> getAverageRating(int boutiqueId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Product/GetAverageRatingByBoutique/$boutiqueId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['averageRating']?.toDouble() ?? 0.0;
    } else {
      throw Exception('Failed to load average rating');
    }
  }
}
