import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductdetailsService {
  final String baseUrl;

  ProductdetailsService({required this.baseUrl});

  Future<bool> submitRating(String productId, double rating) async {
    final url = Uri.parse('$baseUrl/api/ProductRating/rate');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'productId': productId, 'rate': rating}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to submit rating: ${response.statusCode}');
    }
  }
}
