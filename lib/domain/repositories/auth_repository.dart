import 'package:work_assistent_mob/domain/entities/auth_token.dart';
import 'package:work_assistent_mob/domain/entities/login.dart';

abstract class AuthRepository {
  Future<AuthToken> register(Login login);
  Future<void> cacheAuthToken(AuthToken token);
  Future<AuthToken?> getCachedToken();
  Future<void> clearToken();
}