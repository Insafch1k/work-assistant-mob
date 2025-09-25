import 'package:flutter/material.dart';
import 'package:work_assistent_mob/domain/entities/auth_token.dart';
import 'package:work_assistent_mob/domain/entities/login.dart';
import 'package:work_assistent_mob/domain/repositories/auth_repository.dart';


class AuthProvider with ChangeNotifier {
  AuthRepository repository;
  AuthToken? _authToken;
  bool _isLoading = false;
  String? _error;

  AuthProvider({required this.repository});

  AuthToken? get authToken => _authToken;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _authToken != null;

  void updateToken(String token) {
    _authToken = AuthToken(token);
    notifyListeners();
  }

   void setRepository(AuthRepository _repository) {
    repository = _repository;
  }

  Future<void> register(Login login) async {
    try {
      _setLoading(true);
      final token = await repository.register(login);
      _authToken = token;
      await repository.cacheAuthToken(token);
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadCachedToken() async {
    _setLoading(true);
    try {
      final token = await repository.getCachedToken();
      if (token != null) {
        _authToken = token;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    await repository.clearToken();
    _authToken = null;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}