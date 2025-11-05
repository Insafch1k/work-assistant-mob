abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<void> saveData(String email, String password);
  Future<void> overridePassword(String password);
  Future<String?> getToken();
  Future<Map<String, String>?> getData();
  Future<void> deleteToken();
  Future<void> deleteData();
}