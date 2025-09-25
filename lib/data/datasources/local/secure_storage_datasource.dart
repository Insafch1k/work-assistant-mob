import 'package:work_assistent_mob/core/constants/storage_constants.dart';
import 'package:work_assistent_mob/core/utils/secure_storage_utils.dart';

abstract class SecureStorageDataSource {
  Future<void> saveUserName(String userName);
  Future<String?> getUserName();
  Future<void> clearUserName();
}

class SecureStorageDataSourceImpl implements SecureStorageDataSource {
  @override
  Future<void> saveUserName(String userName) async {
    await SecureStorageUtils.storage.write(
      key: StorageConstants.userNameKey,
      value: userName,
      aOptions: SecureStorageUtils.androidOptions,
      iOptions: SecureStorageUtils.iOSOptions,
    );
  }

  @override
  Future<String?> getUserName() async {
    return await SecureStorageUtils.storage.read(
      key: StorageConstants.userNameKey,
      aOptions: SecureStorageUtils.androidOptions,
      iOptions: SecureStorageUtils.iOSOptions,
    );
  }

  @override
  Future<void> clearUserName() async {
    await SecureStorageUtils.storage.delete(
      key: StorageConstants.userNameKey,
      aOptions: SecureStorageUtils.androidOptions,
      iOptions: SecureStorageUtils.iOSOptions,
    );
  }
}
