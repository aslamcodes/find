import 'dart:io';
import 'package:find/authentication/auth_service.dart';
import 'package:find/interfaces/find_user.dart';

class AuthController {
  final AuthService _authService = const AuthService();

  const AuthController();

  Future<void> login(String username, String password) async {
    return _authService.login({'username': username, 'password': password});
  }

  Future<void> register(String username, String password, String email,
      File? profileImage) async {
    return _authService.register({
      'email': email,
      'username': username,
      'password': password,
      'profileImage': profileImage
    });
  }

  // Future<FindUser> getUserData() async {}

  Future<void> logout() async {
    await _authService.logout();
  }
}
