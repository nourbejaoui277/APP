import 'package:app1/utilities/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BoutiqueService {
  final Dio _dio = Dio();
  final String token = SharedPreference.getAccessToken()!;
  final String _baseUrl = "http://10.0.2.2:5267/api";

  Future<bool> checkBoutiqueExists(String userId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/Boutique/GetByUser/$userId',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // if needed
        }),
      );

      return response.statusCode == 200 && response.data != null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return false;
      }
      debugPrint("Boutique check failed: ${e.message}");
      throw Exception("Boutique check failed");
    }
  }

  Future<bool> createBoutique({
    required String name,
    required String description,
    required String address,
    required String contact,
    required String userId,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/Boutique',
        data: {
          'nom': name,
          'description': description,
          'address': address,
          'contact': contact,
          'userId': userId,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          // "Authorization": "Bearer $token",
        }),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint("Failed to create boutique: $e");
      throw Exception("Could not create boutique");
    }
  }
}
