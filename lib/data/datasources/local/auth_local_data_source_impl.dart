import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:work_assistent_mob/data/datasources/local/auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _storage;

  AuthLocalDataSourceImpl(this._storage);

  factory AuthLocalDataSourceImpl.create() {
    return AuthLocalDataSourceImpl(FlutterSecureStorage());
  }

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  @override
  Future<void> saveData(String email, String password) async {
    await _storage.write(key: "email", value: email);
    await _storage.write(key: "password", value: password);
  }

  @override
  Future<void> overridePassword(String password) async {
    await _storage.write(key: "password", value: password);
  }

  @override
  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  @override
Future<Map<String, String>?> getData() async {
  try {
    // Читаем каждый ключ отдельно
    final email = await _storage.read(key: "email");
    final password = await _storage.read(key: "password");
    
    // Проверяем что оба значения не null
    if (email == null || password == null) {
      return null;
    }
    
    // Возвращаем Map с данными
    return {
      'email': email,
      'password': password,
    };
  } catch (e) {
    print('Ошибка получения сохраненных данных: $e');
    return null;
  }
}



  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt_token');
  }

  @override
  Future<void> deleteData() async {
    await _storage.delete(key: "email");
    await _storage.delete(key: "password");
  }
}