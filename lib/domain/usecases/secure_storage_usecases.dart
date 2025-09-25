import 'package:work_assistent_mob/domain/entities/user_entity.dart';
import 'package:work_assistent_mob/domain/repositories/secure_storage_repository.dart';

class SaveUserNameUseCase {
  final SecureStorageRepository repository;

  SaveUserNameUseCase({required this.repository});

  Future<void> call(String userName) async {
    await repository.saveUserName(userName);
  }
}

class GetUserNameUseCase {
  final SecureStorageRepository repository;

  GetUserNameUseCase({required this.repository});

  Future<String?> call() async {
    return await repository.getUserName();
  }
}

class GetUserUseCase {
  final SecureStorageRepository repository;

  GetUserUseCase({required this.repository});

  Future<UserEntity?> call() async {
    return await repository.getUser();
  }
}

class ClearUserNameUseCase {
  final SecureStorageRepository repository;

  ClearUserNameUseCase({required this.repository});

  Future<void> call() async {
    await repository.clearUserName();
  }
}

class HasUserNameUseCase {
  final SecureStorageRepository repository;

  HasUserNameUseCase({required this.repository});

  Future<bool> call() async {
    return await repository.hasUserName();
  }
}