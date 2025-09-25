import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtils {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static const AndroidOptions androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  static const IOSOptions iOSOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );
}