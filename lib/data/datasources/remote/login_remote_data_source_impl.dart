import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:work_assistent_mob/data/datasources/remote/login_remote_data_source.dart';
import 'package:work_assistent_mob/data/models/auth_response_model.dart';
import 'package:work_assistent_mob/data/models/login_model.dart';

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://lucky-pillows-swim.loca.lt/api';

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthResponseModel> authenticate(LoginModel login) async {
    final response = await client.post(
      Uri.parse('$baseUrl/profile/init'),
      body: json.encode(login.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    print('Ответ сервера: ${response.statusCode} ${response.body}');

    if (response.statusCode == 200) {
      try {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        print('ответ: $jsonResponse');
        return AuthResponseModel.fromJson(jsonResponse);
      } catch (e) {
        print('Ошибка парсинга: $e');
        throw Exception('Ошибка парсинга токена: $e');
      }
    } else {
      throw Exception('Ошибка авторизации: ${response.statusCode}');
    }
  }
}
