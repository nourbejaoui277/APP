import 'package:flutter/material.dart';
import '../models/promotion.dart';
import '../services/promotion_service.dart';

class PromotionController extends ChangeNotifier {
  final PromotionService _service = PromotionService();
  List<Promotion> promotions = [];
  bool isLoading = false;

  Future<void> loadPromotions() async {
    isLoading = true;
    notifyListeners();
    try {
      promotions = await _service.fetchPromotions();
    } catch (e) {
      debugPrint('Error: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addPromotion(Promotion promotion) async {
    await _service.addPromotion(promotion);
    await loadPromotions();
  }

  Future<void> updatePromotion(Promotion promotion) async {
    await _service.updatePromotion(promotion);
    await loadPromotions();
  }

  Future<void> deletePromotion(String id) async {
    await _service.deletePromotion(id);
    await loadPromotions();
  }
}
