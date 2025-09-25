import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:work_assistent_mob/data/datasources/remote/address_remote_data_source.dart';

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  static const String _baseUrl = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs';
  final String _apiKey;
  final String _secretKey;

  AddressRemoteDataSourceImpl({required String apiKey, required String secretKey})
      : _apiKey = apiKey,
        _secretKey = secretKey;

  Future<Map<String, String>> _getHeaders() async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $_apiKey',
      'X-Secret': _secretKey,
    };
  }

  @override
  Future<List<Map<String, dynamic>>> suggestAddress(String query) async {
    try {
      final headers = await _getHeaders();
      final body = json.encode({
        'query': query,
        'count': 10,
      });

      print('DaData Request: $query');
      print('Headers: $headers');
      print('Body: $body');

      final response = await http.post(
        Uri.parse('$_baseUrl/suggest/address'),
        headers: headers,
        body: body,
      );

      print('DaData Response Status: ${response.statusCode}');
      print('DaData Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final suggestions = List<Map<String, dynamic>>.from(data['suggestions'] ?? []);
        print('Found ${suggestions.length} suggestions');
        return suggestions;
      } else if (response.statusCode == 403) {
        throw Exception('Ошибка авторизации DaData. Ключи');
      } else {
        throw Exception('Ошибка DaData: ${response.statusCode}');
      }
    } catch (e) {
      print('DaData Error: $e');
      throw Exception('Ошибка При запросе к DaData: $e');
    }
  }
}