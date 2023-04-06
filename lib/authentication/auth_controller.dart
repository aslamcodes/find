import 'dart:io';
import 'package:find/authentication/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<void> login(String username, String password) async {
    return _authService.login({'username': username, 'password': password});
  }

  Future<void> register(
      String username, String password, File? profileImage) async {
    return _authService.register({
      'username': username,
      'password': password,
      'profileImage': profileImage
    });
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}
