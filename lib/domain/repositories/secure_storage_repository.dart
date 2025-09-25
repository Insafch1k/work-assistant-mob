import 'package:work_assistent_mob/domain/entities/user_entity.dart';

abstract class SecureStorageRepository {
  Future<void> saveUserName(String userName);
  Future<String?> getUserName();
  Future<UserEntity?> getUser();
  Future<void> clearUserName();
  Future<bool> hasUserName();
}