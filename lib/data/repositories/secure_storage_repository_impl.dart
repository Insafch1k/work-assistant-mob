import 'package:work_assistent_mob/data/datasources/local/secure_storage_datasource.dart';
import 'package:work_assistent_mob/domain/entities/user_entity.dart';
import 'package:work_assistent_mob/domain/repositories/secure_storage_repository.dart';

class SecureStorageRepositoryImpl implements SecureStorageRepository {
  final SecureStorageDataSource dataSource;

  SecureStorageRepositoryImpl({required this.dataSource});

  @override
  Future<void> saveUserName(String userName) async {
    await dataSource.saveUserName(userName);
  }

  @override
  Future<String?> getUserName() async {
    return await dataSource.getUserName();
  }

  @override
  Future<UserEntity?> getUser() async {
    final userName = await dataSource.getUserName();
    return userName != null ? UserEntity(userName: userName) : null;
  }

  @override
  Future<void> clearUserName() async {
    await dataSource.clearUserName();
  }

  @override
  Future<bool> hasUserName() async {
    final userName = await dataSource.getUserName();
    return userName != null;
  }
}