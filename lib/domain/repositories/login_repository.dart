import 'package:work_assistent_mob/domain/entities/login.dart';

abstract class LoginRepository {
  Future<String> authenticate(Login login);
  Future<String?> getCachedToken();
  Future<void> clearToken();
}