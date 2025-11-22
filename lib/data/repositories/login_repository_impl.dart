import 'package:work_assistent_mob/data/datasources/local/auth_local_data_source.dart';
import 'package:work_assistent_mob/data/datasources/local/auth_local_data_source_impl.dart';
import 'package:work_assistent_mob/data/datasources/remote/login_remote_data_source.dart';
import 'package:work_assistent_mob/data/datasources/remote/login_remote_data_source_impl.dart';
import 'package:work_assistent_mob/data/models/login_model.dart';
import 'package:work_assistent_mob/domain/entities/login.dart';
import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<int> registerMail(Login login) async {
    try {
      final loginModel = LoginModel.fromEntity(login);
      final response = await remoteDataSource.registerMail(loginModel);

      if (response.temporaryId == null) {
        throw Exception('Не получен temporary_id');
      }

      await cacheData(login.email, login.password);
      return response.temporaryId!;
    } catch (e) {
      print('Ошибка регистрации: $e');
      rethrow;
    }
  }

  @override
  Future<String> confirmMail({
    required int temporaryId,
    required int code,
  }) async {
    try {
      final response = await remoteDataSource.confirmMail(
        temporaryId: temporaryId,
        code: code,
      );

      if (response.token == null) {
        throw Exception('Не получен токен');
      }

      await cacheAuthToken(response.token!);
      return response.token!;
    } catch (e) {
      print('Ошибка подтверждения почты: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> loginMail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.loginMail(
        email: email,
        password: password,
      );

      if (response.token == null) {
        throw Exception('Не получен токен');
      }

      final serverRole = response.resolvedRole;

      await cacheAuthToken(response.token!);
      await cacheData(email, password);
      print("Полученная роль: ${serverRole}");
      return {'token': response.token!, 'role': serverRole};
    } catch (e) {
      print('Ошибка авторизации: $e');
      rethrow;
    }
  }

  @override
  Future<int> forgotPassword({required String email}) async {
    try {
      final response = await remoteDataSource.forgotPassword(email: email);

      if (response.temporaryId == null) {
        throw Exception('Не получен temporary_id');
      }

      return response.temporaryId!;
    } catch (e) {
      print('Ошибка запроса восстановления пароля: $e');
      rethrow;
    }
  }

  @override
  Future<bool> recoveryCode({
    required int temporaryId,
    required int code,
  }) async {
    try {
      await remoteDataSource.recoveryCode(temporaryId: temporaryId, code: code);
      return true;
    } catch (e) {
      print('Ошибка проверки кода восстановления: $e');
      return false;
    }
  }

  @override
  Future<String> recoveryPassword({
    required int temporaryId,
    required int code,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.recoveryPassword(
        temporaryId: temporaryId,
        code: code,
        password: password,
      );

      if (response.token == null) {
        throw Exception('Не получен токен');
      }

      await cacheAuthToken(response.token!);
      await cacheOverridePassword(password);
      return response.token!;
    } catch (e) {
      print('Ошибка восстановления пароля: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await remoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      if (response.token == null) {
        throw Exception('Не получен токен');
      }
      print('Пароль успешно изменен. Роль: ${response.role}');
      await cacheAuthToken(response.token!);
      await cacheOverridePassword(newPassword);
      return {
      'token': response.token!,
      'role': response.role!,
    };
    } catch (e) {
      print('Ошибка смены пароля: $e');
      rethrow;
    }
  }

  @override
  Future<void> cacheAuthToken(String token) async {
    await localDataSource.saveToken(token);
  }

  @override
  Future<void> cacheData(String email, String password) async {
    await localDataSource.saveData(email, password);
  }

  @override
  Future<void> cacheOverridePassword(String password) async {
    await localDataSource.overridePassword(password);
  }

  @override
  Future<String?> getCachedToken() async {
    return await localDataSource.getToken();
  }

  @override
  Future<Map<String, String>?> getData() async {
    return await localDataSource.getData();
  }

  @override
  Future<void> clearToken() async {
    await localDataSource.deleteToken();
  }

  @override
  Future<void> clearData() async {
    await localDataSource.deleteData();
  }

  @override
  Future<bool> validateToken(String token) async {
    try {
      await remoteDataSource.validateToken(token: token);
      return true;
    } catch (e) {
      return false;
    }
  }
}
