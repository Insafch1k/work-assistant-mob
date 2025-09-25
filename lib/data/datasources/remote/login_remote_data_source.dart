import "dart:convert";
import "package:http/http.dart" as http;
import "package:work_assistent_mob/data/models/auth_response_model.dart";
import "package:work_assistent_mob/data/models/login_model.dart";

abstract class LoginRemoteDataSource {
  Future<AuthResponseModel> authenticate(LoginModel login); 
}

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

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Ошибка аутентификации: ${response.statusCode}');
    }
  }
}
