class AuthResponseModel {
  final String token;

  AuthResponseModel({required this.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    print('JSON: $json');

    // Проверяем все возможные варианты названия токена
    final token =
        json['token'] ??
        json['access_token'] ??
        json['jwt_token'] ??
        json['accessToken'] ??
        json['jwtToken'];

    if (token == null || token.isEmpty) {
      throw FormatException(
        'Токен не найден в ответе. Доступные ключи: ${json.keys}',
      );
    }

    print('[TOKEN PARSE] Extracted token: $token');
    return AuthResponseModel(token: token);
  }
}
