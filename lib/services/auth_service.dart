import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveUserRole(String role) async {
    await _storage.write(key: 'user_role', value: role);
  }

  Future<String?> getUserRole() async {
    return await _storage.read(key: 'user_role');
  }

  Future<bool> isAdmin() async {
    String? role = await getUserRole();
    return role == 'admin';
  }

  Future<bool> isSeller() async {
    String? role = await getUserRole();
    return role == 'seller';
  }

  Future<void> clearUserRole() async {
    await _storage.delete(key: 'user_role');
  }
}
