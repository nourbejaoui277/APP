import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier {
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = true;

  bool get pushNotificationsEnabled => _pushNotificationsEnabled;
  bool get emailNotificationsEnabled => _emailNotificationsEnabled;

  void setPushNotificationsEnabled(bool value) {
    _pushNotificationsEnabled = value;
    notifyListeners();
    // Implement logic to update preferences in database or storage
  }

  void setEmailNotificationsEnabled(bool value) {
    _emailNotificationsEnabled = value;
    notifyListeners();
    // Implement logic to update preferences in database or storage
  }
}
