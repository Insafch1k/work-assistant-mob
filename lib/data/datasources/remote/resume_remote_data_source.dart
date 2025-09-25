import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:work_assistent_mob/data/models/resume_model.dart';
import 'package:work_assistent_mob/presentation/providers/auth_provider.dart';

abstract class ResumeRemoteDataSource {
  Future<ResponseResumeModel> sendResume(RequestResumeModel request);
  Future<ResponseResumeModel> redoResume(RequestResumeModel request);
  Future<void> redoEmployerResume(RequestEmployerResumeModel request);
  Future<List<ResponseResumeModel>> getResumes();
  Future<List<ResponseEmployerResumeModel>> getEmployerResumes();
  Future<void> deleteResume();
}

class ResumeRemoteDataSourceImpl implements ResumeRemoteDataSource {
  final http.Client client;
  final AuthProvider authProvider;
  final String baseUrl = 'https://lucky-pillows-swim.loca.lt/api';

  ResumeRemoteDataSourceImpl({
    required this.client,
    required this.authProvider,
  });

  // Метод для получения заголовков с авторизацией
  Map<String, String> _getAuthHeaders() {
    final token = authProvider.authToken?.token;
    if (token == null) {
      throw Exception('Пользователь не аутентифицировался');
    }

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Валидация ответа сервера
  void _validateResponse(http.Response response) {
    if (response.statusCode == 401) {
      throw Exception('Время сессии истекло');
    } else if (response.statusCode != 200) {
      throw Exception('Статус ответа сервера ${response.statusCode}');
    }
  }

  @override
  Future<ResponseResumeModel> sendResume(RequestResumeModel request) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/resumes'),
        headers: _getAuthHeaders(),
        body: json.encode(request.toJson()),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      _validateResponse(response);

      return ResponseResumeModel.fromJson(json.decode(response.body));
    } catch (e) {
      print('Ошибка в отправке рещюме: $e');
      throw Exception('Ошибка отравлки резюме: ${e.toString()}');
    }
  }

  @override
  Future<ResponseResumeModel> redoResume(RequestResumeModel request) async {
    try {
      final response = await client.patch(
        Uri.parse('$baseUrl/resumes/me'),
        headers: _getAuthHeaders(),
        body: json.encode(request.toJson()),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа ${response.body}');

      _validateResponse(response);

      return ResponseResumeModel.fromJson(json.decode(response.body));
    } catch (e) {
      print('Ошибка в редактировании резюме: $e');
      throw Exception('Ошибка в редактировании резюме: ${e.toString()}');
    }
  }

  @override
  Future<void> redoEmployerResume(RequestEmployerResumeModel request) async {
    try {
      final response = await client.patch(
        Uri.parse('$baseUrl/profile'),
        headers: _getAuthHeaders(),
        body: json.encode(request.toJson()),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      _validateResponse(response);

      await getEmployerResumes();
    } catch (e) {
      print('Ошибка в редактировании резюме: $e');
      throw Exception('Ошибка в редактировании резюме: ${e.toString()}');
    }
  }

  @override
  Future<List<ResponseResumeModel>> getResumes() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/resumes'),
        headers: _getAuthHeaders(),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      _validateResponse(response);

      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic>) {
        return [ResponseResumeModel.fromJson(responseData)];
      } else if (responseData is List) {
        return responseData
            .map((json) => ResponseResumeModel.fromJson(json))
            .toList();
      }

      throw Exception('Неправильный формат');
    } catch (e) {
      print('Ошибка в получении рещюме: $e');
      rethrow;
    }
  }

  @override
  Future<List<ResponseEmployerResumeModel>> getEmployerResumes() async {
    final response = await client.get(
      Uri.parse('$baseUrl/profile/me'),
      headers: _getAuthHeaders(),
    );

    _validateResponse(response);
    final decoded = json.decode(response.body);

    if (decoded is List) {
      return decoded.map<ResponseEmployerResumeModel>((item) {
        if (item is Map<String, dynamic>) {
          return ResponseEmployerResumeModel.fromJson(item);
        }
        throw Exception('Неправильный формат');
      }).toList();
    } else if (decoded is Map<String, dynamic>) {
      return [ResponseEmployerResumeModel.fromJson(decoded)];
    }

    throw Exception('Неправильный формат');
  }

  @override
  Future<void> deleteResume() async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/resumes'),
        headers: _getAuthHeaders(),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      if (response.statusCode != 200 && response.statusCode != 204) {
        _validateResponse(response);
      }
    } catch (e) {
      print('Ошибка удаления резюме: $e');
      throw Exception('Ошиюка удаления резюме: ${e.toString()}');
    }
  }
}
