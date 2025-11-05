import 'package:work_assistent_mob/domain/entities/login.dart';

abstract class LoginRepository {
  // Регистрация и аутентификация
  Future<int> registerMail(Login login);
  Future<String> confirmMail({required int temporaryId, required int code});
  Future<Map<String, dynamic>> loginMail({required String email, required String password});
  
  // Восстановление пароля
  Future<int> forgotPassword({required String email});
  Future<bool> recoveryCode({required int temporaryId, required int code});
  Future<String> recoveryPassword({
    required int temporaryId,
    required int code,
    required String password,
  });
  
  // Управление паролем
  Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
  
  // Управление токеном
  Future<void> cacheAuthToken(String token);
  Future<String?> getCachedToken();
  Future<void> clearToken();

  // Управление данными  
  Future<void> cacheData(String email, String password);
  Future<Map<String,String>?> getData();
  Future<void> cacheOverridePassword(String password);
  Future<void> clearData();


  // Валидация
  Future<bool> validateToken(String token);
}