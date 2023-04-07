import 'package:find/authentication/auth_repository.dart';

class AuthService {
  const AuthService();
  final AuthRepository _authRepository = const AuthRepository();
  Future<void> login(Map<String, dynamic> userValues) async {
    return await _authRepository.login(userValues);
  }

  Future<void> register(Map<String, dynamic> userValues) async {
    return await _authRepository.register(userValues);
  }

  Future<void> logout() async {
    return await _authRepository.logout();
  }

  void getUserDetails() {}
}
