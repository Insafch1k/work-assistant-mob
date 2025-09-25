import 'package:flutter/material.dart';
import 'package:work_assistent_mob/domain/entities/login.dart';
import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class LoginProvider with ChangeNotifier {
  final LoginRepository repository; 
  String? _authToken;
  bool _isLoading = false;

  LoginProvider({required this.repository});

  String? get authToken => _authToken;
  bool get isLoading => _isLoading;

  Future<void> performLogin(Login login) async {
    try {
      _isLoading = true;
      notifyListeners();

      final token = await repository.authenticate(login);

      if (token.isEmpty) {
        throw Exception('Недействительный токен');
      }

      _authToken = token;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Ошибка в performLogin: $e');
      throw Exception('Ошибка авторизации: $e');
    }
  }

  Future<void> loadCachedToken() async {
    _authToken = await repository.getCachedToken();
    notifyListeners();
  }

  Future<void> logout() async {
    await repository.clearToken();
    _authToken = null;
    notifyListeners();
  }
}
