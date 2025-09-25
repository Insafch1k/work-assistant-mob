import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:work_assistent_mob/data/datasources/remote/auth_remote_data_source.dart';
import 'package:work_assistent_mob/data/models/auth_response_model.dart';
import 'package:work_assistent_mob/data/models/login_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://lucky-pillows-swim.loca.lt/api';

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthResponseModel> register(LoginModel login) async {
    print('Данные для отправки: ${login.toJson()}');

    final response = await client.post(
      Uri.parse('$baseUrl/profile/init'),
      body: json.encode(login.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    
    print('Статус ответа: ${response.statusCode}');
    print('Тело ответа: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final jsonResponse = json.decode(response.body);
        print('Ответ : $jsonResponse');
        return AuthResponseModel.fromJson(jsonResponse);
      } catch (e) {
        print('Ошибка парсинга ответа: $e');
        throw Exception('Ошибка парсинга ответа: $e');
      }
    } else {
      throw Exception('Ошибка регистрации: ${response.statusCode}');
    }
  }
}
