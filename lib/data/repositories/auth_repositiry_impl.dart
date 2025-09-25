import 'package:work_assistent_mob/data/datasources/local/auth_local_data_source.dart';
import 'package:work_assistent_mob/data/datasources/remote/auth_remote_data_source.dart';
import 'package:work_assistent_mob/data/models/login_model.dart';
import 'package:work_assistent_mob/domain/entities/auth_token.dart';
import 'package:work_assistent_mob/domain/entities/login.dart';
import 'package:work_assistent_mob/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AuthToken> register(Login login) async {
    try {
      final model = LoginModel.fromEntity(login);
      final response = await remoteDataSource.register(model);

      if (response.token.isEmpty) {
        throw Exception('Получен пустой токен');
      }

      await localDataSource.saveToken(response.token);
      
      // Проверяем сохранение
      final savedToken = await localDataSource.getToken();
      if (savedToken != response.token) {
        throw Exception('Токен не сохранился в кэше');
      }

      return AuthToken(response.token);
    } catch (e) {
      print('Ошибка регистрации: $e');
      rethrow;
    }
  }

  @override
  Future<void> cacheAuthToken(AuthToken token) async {
    await localDataSource.saveToken(token.token);
  }

  @override
  Future<AuthToken?> getCachedToken() async {
    final token = await localDataSource.getToken();
    return token != null ? AuthToken(token) : null;
  }

  @override
  Future<void> clearToken() async {
    await localDataSource.deleteToken();
  }
}