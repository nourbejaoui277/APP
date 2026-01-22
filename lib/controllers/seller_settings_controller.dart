import 'package:app1/views/seller/seller_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:app1/models/seller_settings_model.dart';
import 'package:app1/services/seller_settings_service.dart';
import '../models/boutique.dart';

class SellerSettingsController extends ChangeNotifier {
  final SellerSettingsService _service = SellerSettingsService();

  SellerSettingsModel? sellersettngs;
  Boutique? boutique;
  bool isLoading = false;

  Future<void> fetchData(String userId, String boutiqueId) async {
    isLoading = true;
    notifyListeners();
    try {
      final responses = await Future.wait([
        _service.fetchsellersettings(userId),
        _service.fetchBoutique(boutiqueId),
      ]);
      sellersettngs = responses[0] as SellerSettingsModel?;
      boutique = responses[1] as Boutique;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateBoutique(Boutique updatedBoutique) async {
    await _service.updateBoutique(updatedBoutique);
    boutique = updatedBoutique;
    notifyListeners();
  }

  void updateUserProfile(SellerSettingsModel updatedUser) {
    sellersettngs = updatedUser as SellerSettingsModel?;
    notifyListeners();
  }
}
