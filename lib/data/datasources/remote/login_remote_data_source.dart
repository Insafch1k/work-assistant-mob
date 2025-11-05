import "dart:convert";
import "package:http/http.dart" as http;
import "package:work_assistent_mob/data/models/auth_response_model.dart";
import "package:work_assistent_mob/data/models/login_model.dart";

abstract class LoginRemoteDataSource {
  // Регистрация и аутентификация
  Future<AuthResponseModel> registerMail(LoginModel login);
  Future<AuthResponseModel> confirmMail({required int temporaryId, required int code});
  Future<AuthResponseModel> loginMail({required String email, required String password});
  
  // Восстановление пароля
  Future<AuthResponseModel> forgotPassword({required String email});
  Future<void> recoveryCode({required int temporaryId, required int code});
  Future<AuthResponseModel> recoveryPassword({
    required int temporaryId,
    required int code,
    required String password,
  });
  
  // Управление паролем
  Future<AuthResponseModel> changePassword({
    required String oldPassword,
    required String newPassword,
  });
  
  // Валидация токена (опционально)
  Future<AuthResponseModel> validateToken({required String token});
}