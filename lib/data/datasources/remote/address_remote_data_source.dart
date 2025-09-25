abstract class AddressRemoteDataSource {
  Future<List<Map<String, dynamic>>> suggestAddress(String query);
}