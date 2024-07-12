import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  String _name = 'John Doe';
  String _email = 'john.doe@example.com';
  String _phone = '+1234567890';

  String get name => _name;
  String get email => _email;
  String get phone => _phone;

  void updateProfile(String name, String email, String phone) {
    _name = name;
    _email = email;
    _phone = phone;
    notifyListeners();
  }
}
