import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:work_assistent_mob/data/datasources/local/auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _storage;

  AuthLocalDataSourceImpl(this._storage);

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt_token');
  }
}