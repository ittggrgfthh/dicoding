import 'package:flutter/material.dart';

import '../data/repositories/auth_repository.dart';
import '../model/login.dart';
import '../model/response_default.dart';
import '../model/user.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider({required this.authRepository});

  bool isLoading = false;

  Future<LoginResponse> login(User user) async {
    isLoading = true;
    notifyListeners();
    try {
      return await authRepository.login(user);
    } catch (e) {
      return LoginResponse(
        error: true,
        message: e.toString(),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    await authRepository.logout();

    isLoading = false;
    notifyListeners();
  }

  Future<ResponseDefault> register(User user) async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await authRepository.register(user);
      return result;
    } catch (e) {
      return ResponseDefault(
        error: true,
        message: e.toString(),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
