import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;

  static const _keyAccessToken = 'AccessToken';
  static const _keyUserId = 'UserId';
  static const _keyUserRole = 'UserRole';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setAcessToken(String access) async =>
      await _preferences.setString(_keyAccessToken, access);

  static String? getAccessToken() => _preferences.getString(_keyAccessToken);

  static Future setUserId(String userId) async =>
      await _preferences.setString(_keyUserId, userId);

  static String? getUserId() => _preferences.getString(_keyUserId);

  static Future setUserRole(String role) async =>
      await _preferences.setString(_keyUserRole, role);

  static String? getUserRole() => _preferences.getString(_keyUserRole);

  static Future clearSharedPreference() async {
    await _preferences.clear();
    debugPrint('clearSharedPreference DONE');
  }
}
