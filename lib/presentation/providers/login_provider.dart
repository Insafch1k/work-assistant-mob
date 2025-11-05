import 'package:flutter/material.dart';
import 'package:work_assistent_mob/data/repositories/login_repository_impl.dart';
import 'package:work_assistent_mob/domain/entities/login.dart';
import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class LoginProvider with ChangeNotifier {
  final LoginRepository repository;
  String? _authToken;
  String? _userRole;
  bool _isLoading = false;
  String? _errorMessage;
  int? _temporaryId;

  LoginProvider({required this.repository});

  String? get authToken => _authToken;
  String? get userRole => _userRole;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int? get temporaryId => _temporaryId;

  // Сброс ошибок
  void _clearError() {
    _errorMessage = null;
  }

  // Установка ошибки
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Регистрация пользователя
  Future<void> register(Login login) async {
    try {
      _clearError();
      _isLoading = true;
      notifyListeners();

      _temporaryId = await repository.registerMail(login);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _setError('Ошибка регистрации: $e');
      print('Ошибка в register: $e');
      rethrow;
    }
  }

  // Подтверждение почты
  Future<void> confirmEmail({required int code}) async {
    try {
      if (_temporaryId == null) {
        throw Exception('Сначала выполните регистрацию');
      }

      _clearError();
      _isLoading = true;
      notifyListeners();

      final token = await repository.confirmMail(
        temporaryId: _temporaryId!,
        code: code,
      );

      _authToken = token;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _setError('Ошибка подтверждения почты: $e');
      print('Ошибка в confirmEmail: $e');
      rethrow;
    }
  }

  // Авторизация пользователя
  Future<void> login({required String email, required String password}) async {
    try {
      _clearError();
      _isLoading = true;
      notifyListeners();

      final result = await repository.loginMail(
        email: email,
        password: password,
      );

      _authToken = result['token'] as String;
      _userRole = result['role'] as String?;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _setError('Ошибка авторизации: $e');
      print('Ошибка в login: $e');
      rethrow;
    }
  }

  // Восстановление пароля - запрос кода
  Future<void> forgotPassword({required String email}) async {
    try {
      _clearError();
      _isLoading = true;
      notifyListeners();

      _temporaryId = await repository.forgotPassword(email: email);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _setError('Ошибка запроса восстановления пароля: $e');
      print('Ошибка в forgotPassword: $e');
      rethrow;
    }
  }

  // Проверка кода восстановления
  Future<bool> verifyRecoveryCode({required int code}) async {
    try {
      if (_temporaryId == null) {
        throw Exception('Сначала запросите восстановление пароля');
      }

      _clearError();
      _isLoading = true;
      notifyListeners();

      final isValid = await repository.recoveryCode(
        temporaryId: _temporaryId!,
        code: code,
      );

      _isLoading = false;
      notifyListeners();
      return isValid;
    } catch (e) {
      _isLoading = false;
      _setError('Неверный код восстановления: $e');
      print('Ошибка в verifyRecoveryCode: $e');
      return false;
    }
  }

  // Восстановление пароля с новым паролем
  Future<void> recoverPassword({
    required String newPassword,
    required int code,
  }) async {
    try {
      if (_temporaryId == null) {
        throw Exception('Сначала выполните проверку кода');
      }

      _clearError();
      _isLoading = true;
      notifyListeners();

      final token = await repository.recoveryPassword(
        temporaryId: _temporaryId!,
        code: code,
        password: newPassword,
      );

      _authToken = token;
      _temporaryId =
          null; // Очищаем temporary_id после успешного восстановления
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _setError('Ошибка восстановления пароля: $e');
      print('Ошибка в recoverPassword: $e');
      rethrow;
    }
  }

  // Смена пароля
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      _clearError();
      _isLoading = true;
      notifyListeners();

      final result = await repository.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      _authToken = result['token'] as String;
      _userRole = result['role'] as String;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _setError('Ошибка смены пароля: $e');
      print('Ошибка в changePassword: $e');
      rethrow;
    }
  }

  // Загрузка кэшированного токена
  Future<void> loadCachedToken() async {
    try {
      _clearError();
      _authToken = await repository.getCachedToken();
      notifyListeners();
    } catch (e) {
      _setError('Ошибка загрузки токена: $e');
      print('Ошибка в loadCachedToken: $e');
    }
  }

  // Выход из системы
  Future<void> logout() async {
    try {
      await repository.clearToken();
      _authToken = null;
      _temporaryId = null;
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Ошибка выхода: $e');
      print('Ошибка в logout: $e');
    }
  }

  // Валидация токена
  Future<bool> validateToken() async {
    if (_authToken == null) return false;

    try {
      return await repository.validateToken(_authToken!);
    } catch (e) {
      print('Ошибка валидации токена: $e');
      return false;
    }
  }

  // Проверка авторизации
  bool get isAuthenticated => _authToken != null && _authToken!.isNotEmpty;

  // Очистка temporary_id (например, при переходе между экранами)
  void clearTemporaryId() {
    _temporaryId = null;
    notifyListeners();
  }

  // Очистка всех данных
  void clearAll() {
    _authToken = null;
    _temporaryId = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
