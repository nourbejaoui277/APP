import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;

  static const _keyAccessToken = 'AccessToken';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setAcessToken(String access) async =>
      await _preferences.setString(_keyAccessToken, access);

  static String? getAccessToken() => _preferences.getString(_keyAccessToken);

  static Future clearSharedPreference() async {
    await _preferences.clear();
    debugPrint('clearSharedPreference DONE');
  }
}
