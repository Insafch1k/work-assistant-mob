import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:work_assistent_mob/data/datasources/local/auth_local_data_source.dart';
import 'package:work_assistent_mob/data/datasources/remote/login_remote_data_source.dart';
import 'package:work_assistent_mob/data/models/auth_response_model.dart';
import 'package:work_assistent_mob/data/models/login_model.dart';
import 'package:work_assistent_mob/domain/repositories/login_repository.dart';
import 'package:work_assistent_mob/domain/usecases/get_cached_token.dart';

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource localDataSource;
  final String baseUrl = "http://10.0.2.2:5000/api";
  

  LoginRemoteDataSourceImpl({
    required this.client,
    required this.localDataSource, // ← ДОБАВЬТЕ ЭТО
  }) {
    print('=== LoginRemoteDataSourceImpl CONSTRUCTOR ===');
    print('Client passed to constructor: $client');
  }

  // Регистрация пользователя
  @override
  Future<AuthResponseModel> registerMail(LoginModel login) async {
    print('=== registerMail METHOD ===');
    print('Client in registerMail: $client');

    if (client == null) {
      throw Exception('CLIENT IS NULL IN registerMail!');
    }

    final response = await client.post(
      Uri.parse('$baseUrl/auth/register_mail'),
      body: json.encode(login.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    return _handleResponse(response, 'регистрации');
  }

  // Подтверждение почты
  @override
  Future<AuthResponseModel> confirmMail({
    required int temporaryId,
    required int code,
  }) async {
    print('🔍 === CONFIRM MAIL DEBUG ===');
    print('📤 Request Details:');
    print('  URL: $baseUrl/auth/confirm_mail');
    print('  temporaryId: $temporaryId (type: ${temporaryId.runtimeType})');
    print('  code: $code (type: ${code.runtimeType})');

    final requestBody = {'temporary_id': temporaryId, 'code': code};

    print('  Request Body: $requestBody');
    print('  JSON Body: ${json.encode(requestBody)}');

    try {
      final response = await client.post(
        Uri.parse('$baseUrl/auth/confirm_mail'),
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      print('📥 Response Details:');
      print('  Status Code: ${response.statusCode}');
      print('  Headers: ${response.headers}');
      print('  Body: ${response.body}');
      print('  Body Length: ${response.body.length}');

      return _handleResponse(response, 'подтверждения почты');
    } catch (e) {
      print('❌ Confirm Mail Exception: $e');
      rethrow;
    }
  }

  // Авторизация
  @override
  Future<AuthResponseModel> loginMail({
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/login_mail'),
      body: json.encode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    return _handleResponse(response, 'авторизации');
  }

  // Запрос на восстановление пароля
  @override
  Future<AuthResponseModel> forgotPassword({required String email}) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/forgot_password'),
      body: json.encode({'email': email}),
      headers: {'Content-Type': 'application/json'},
    );

    return _handleResponse(response, 'восстановления пароля');
  }

  // Проверка кода восстановления
  @override
  Future<void> recoveryCode({
    required int temporaryId,
    required int code,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/recovery_code'),
      body: json.encode({'temporary_id': temporaryId, 'code': code}),
      headers: {
      'Content-Type': 'application/json',
    },
      
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка проверки кода: ${response.statusCode}');
    }
  }

  // Восстановление пароля
  @override
  Future<AuthResponseModel> recoveryPassword({
    required int temporaryId,
    required int code,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/recovery_password'),
      body: json.encode({
        'temporary_id': temporaryId,
        'code': code,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    return _handleResponse(response, 'восстановления пароля');
  }

  // Смена пароля
  @override
  Future<AuthResponseModel> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final token = await localDataSource.getToken();
    final response = await client.post(
      Uri.parse('$baseUrl/auth/change_password'),
      body: json.encode({
        'old_password': oldPassword,
        'new_password': newPassword,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return _handleResponse(response, 'смены пароля');
  }

  // Валидация токена (опционально)
  @override
  Future<AuthResponseModel> validateToken({required String token}) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/validate_token'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return _handleResponse(response, 'валидации токена');
  }

  // Общий обработчик ответов
  AuthResponseModel _handleResponse(http.Response response, String operation) {
    print(
      'Ответ сервера ($operation): ${response.statusCode} ${response.body}',
    );

    if (response.statusCode == 200) {
      try {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        return AuthResponseModel.fromJson(jsonResponse);
      } catch (e) {
        print('Ошибка парсинга: $e');
        throw Exception('Ошибка парсинга ответа при $operation: $e');
      }
    } else {
      throw Exception(
        'Ошибка $operation: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
