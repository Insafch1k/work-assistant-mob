import "dart:convert";
import "package:http/http.dart" as http;
import "package:work_assistent_mob/data/models/advertisement_model.dart";
import "package:work_assistent_mob/presentation/providers/auth_provider.dart";

class AdvertisementRemoteDataSource {
  final http.Client client;
  final AuthProvider authProvider;
  final String baseUrl = 'https://lucky-pillows-swim.loca.lt/api';

  AdvertisementRemoteDataSource({
    required this.client,
    required this.authProvider,
  });

  // Метод для получения заголовков с авторизацией
  Map<String, String> _getAuthHeaders() {
    final token = authProvider.authToken?.token;
    print('Используемый токен: $token');
    if (token == null) {
      throw Exception('Пользователь не аутентифицирован.');
    }

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<ResponseAdvertisementModel>> getAdvertisements() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/jobs/finders'),
        headers: _getAuthHeaders(),
      );

      print('Response status: ${response.statusCode}'); // Логируем статус
      print('Response body: ${response.body}'); // Логируем тело ответа

      _validateResponse(response);

      final List<dynamic> jsonAdvertisements = json.decode(response.body);
      return jsonAdvertisements.map((json) {
        try {
          return ResponseAdvertisementModel.fromJson(json);
        } catch (e) {
          print('Ошибка парсинга обьявлений: $e');
          print('Ошибочный json: $json');
          rethrow;
        }
      }).toList();
    } catch (e) {
      print('Ошибка в getAdvertisements: $e');
      rethrow;
    }
  }

  Future<List<ResponseFilteredAdvertisementModel>> getFilteredAdvertisements(
    String city,
  ) async {
    try {
      // Создаем тело запроса с городом
      final Map<String, dynamic> requestBody = {'city': city};

      final response = await client.post(
        Uri.parse('$baseUrl/jobs/filter'),
        headers: _getAuthHeaders(),
        body: json.encode(requestBody), // Преобразуем в JSON строку
      );

      print('Статус ответа : ${response.statusCode}'); // Логируем статус
      print('Тело ответа : ${response.body}'); // Логируем тело ответа
      

      _validateResponse(response);

      final List<dynamic> jsonAdvertisements = json.decode(response.body);
      return jsonAdvertisements.map((json) {
        try {
          return ResponseFilteredAdvertisementModel.fromJson(json);
        } catch (e) {
          print('Ошибка парсинга объявления: $e');
          print('Проблемный JSON: $json');
          rethrow;
        }
      }).toList();
    } catch (e) {
      print('Ошибка в getFilteredAdvertisements: $e');
      
      rethrow;
    }
  }

  Future<List<ResponseEmployerAdvertisementModel>>
  getEmployersAdvertisements() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/jobs/me'),
        headers: _getAuthHeaders(),
      );

      print('Статус ответа: ${response.statusCode}'); // Логируем статус
      print('Тело ответа: ${response.body}'); // Логируем тело ответа

      _validateResponse(response);

      final List<dynamic> jsonAdvertisements = json.decode(response.body);
      return jsonAdvertisements.map((json) {
        try {
          return ResponseEmployerAdvertisementModel.fromJson(json);
        } catch (e) {
          print('Ошибка парсинга обьявлений работодателя: $e');
          print('Проблемный JSON: $json');
          rethrow;
        }
      }).toList();
    } catch (e) {
      print('Ошибка  в getEmployerAdvertisements: $e');
      rethrow;
    }
  }

  Future<DetailedResponseAdvertisementModel> getDetailedAdvertisement(
    int jobId,
  ) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/jobs/$jobId/seeall'),
        headers: _getAuthHeaders(),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      _validateResponse(response);

      final responseData = json.decode(response.body);
      print('Полученные данные : $responseData');

      final advertisement = DetailedResponseAdvertisementModel.fromJson(
        responseData,
      );
      print('Создано обьявление: ${advertisement.toEntity()}');

      return advertisement;
    } catch (e) {
      print('ошибка в getDetailedAdvertisement: $e');
      throw Exception('Не удалось загрузить подробное обьявление: ${e.toString()}');
    }
  }

  Future<List<ResponseAdvertisementModel>>
  getAdvertisementsFromHistory() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/jobs/history'),
        headers: _getAuthHeaders(),
      );

      _validateResponse(response);

      final List<dynamic> jsonAdvertisements = json.decode(response.body);
      return jsonAdvertisements
          .map((json) => ResponseAdvertisementModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Ошибка загрузки обьявлений из истории: ${e.toString()}');
    }
  }

  Future<List<FavoriteAdvertisementModel>> getFavoriteAdvertisements() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/jobs/get_favorite'),
        headers: _getAuthHeaders(),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа ${response.body}');

      if (response.statusCode == 404) {
        return [];
      }

      _validateResponse(response);

      final dynamic jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        return jsonResponse
            .map((json) => FavoriteAdvertisementModel.fromJson(json))
            .toList();
      } else if (jsonResponse is Map) {
        if (jsonResponse['data'] is List) {
          return (jsonResponse['data'] as List)
              .map((json) => FavoriteAdvertisementModel.fromJson(json))
              .toList();
        }
      }

      throw Exception('Неверный формат');
    } catch (e) {
      print('Ошибка в getFavoriteAdvertisements: $e');
      rethrow;
    }
  }

  Future<void> addAdvertisementToFavorite(int job_id) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/jobs/$job_id/add_favorite'),
        headers: _getAuthHeaders(),
        body: json.encode({'job_id': job_id}),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      _validateResponse(response);
    } catch (e) {
      throw Exception(
        'Ошибка добавления обьявления в избранное: ${e.toString()}',
      );
    }
  }

  Future<void> deleteAdvertisementFromFavorite(int job_id) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/jobs/$job_id/remove_favorite'),
        headers: _getAuthHeaders(),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      _validateResponse(response);
    } catch (e) {
      throw Exception(
        'ошибка в удалении из избранного: ${e.toString()}',
      );
    }
  }

  Future<String> createAdvertisement(
    RequestCreateAdvertisementModel advertisement,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/jobs'),
        headers: _getAuthHeaders(),
        body: json.encode(advertisement.toJson()),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      _validateResponse(response);

      final responseData = json.decode(response.body);

      if (responseData['message'] != null) {
        return responseData['message'] as String;
      } else {
        throw Exception('Нет сообщения в ответе');
      }
    } catch (e) {
      print('Ошибка в создании обьвления: $e');
      throw Exception('Ошибка создания обьявления: ${e.toString()}');
    }
  }

  Future<String> reductAdvertisement(
    RequestCreateAdvertisementModel advertisement,
    int job_id,
  ) async {
    try {
      final response = await client.patch(
        Uri.parse('$baseUrl/jobs/me/${job_id}'),
        headers: _getAuthHeaders(),
        body: json.encode(advertisement.toJson()),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      _validateResponse(response);

      final responseData = json.decode(response.body);

      if (responseData['message'] != null) {
        return responseData['message'] as String;
      } else {
        throw Exception('Нет message в ответе');
      }
    } catch (e) {
      print('Ошибка редактирования: $e');
      throw Exception('Ошибка редактирования: ${e.toString()}');
    }
  }

  Future<String> deleteAdvertisement(int jobId) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/jobs/me/$jobId'),
        headers: _getAuthHeaders(),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      _validateResponse(response);

      final responseData = json.decode(response.body);

      return responseData['message'] as String? ??
          'Объявление успешно удалено';
    } catch (e) {
      print('Ошибка в удалении обьявления: $e');
      throw Exception('Ошибка в удалении обьявления: ${e.toString()}');
    }
  }

  // Валидация ответа сервера
  void _validateResponse(http.Response response) {
    if (response.statusCode == 401) {
      throw Exception('Время сессии истекло');
    } else if (response.statusCode != 200) {
      throw Exception('Статус код сервера ${response.statusCode}');
    }
  }
}
