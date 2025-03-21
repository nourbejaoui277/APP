import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier {
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = true;

  bool get pushNotificationsEnabled => _pushNotificationsEnabled;
  bool get emailNotificationsEnabled => _emailNotificationsEnabled;

  void setPushNotificationsEnabled(bool value) {
    _pushNotificationsEnabled = value;
    notifyListeners();
  }

  void setEmailNotificationsEnabled(bool value) {
    _emailNotificationsEnabled = value;
    notifyListeners();
  }
}
