import 'package:work_assistent_mob/data/models/view_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:work_assistent_mob/presentation/providers/auth_provider.dart';

abstract class ViewDataSource {
  Future<ViewModel> createView(int job_id);
}

class ViewRemoteDataSource implements ViewDataSource {
  final http.Client client;
  final AuthProvider authProvider;
  final String baseUrl = 'https://lucky-pillows-swim.loca.lt/api';

  ViewRemoteDataSource({
    required this.client,
    required this.authProvider,
  });

  Map<String, String> _getAuthHeaders() {
    final token = authProvider.authToken?.token;
    if (token == null) {
      throw Exception('Пользователь не аутентифицирован');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<ViewModel> createView(int job_id) async { // Убрали параметр ViewModel
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/jobs/$job_id/view'),
        headers: _getAuthHeaders(),
        body: json.encode({}), // Пустое тело запроса
      );
      
      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа: ${response.body}');
      
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body) as Map<String, dynamic>;
        return ViewModel.fromJson(responseJson);
      } else {
        throw Exception('Статус ответа создания просмотра: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка в создании истории: $e');
      throw Exception('Ошибка в создании просмотра: ${e.toString()}');
    }
  }
}