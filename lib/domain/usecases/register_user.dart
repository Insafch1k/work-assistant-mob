import 'package:work_assistent_mob/domain/entities/auth_token.dart';
import 'package:work_assistent_mob/domain/entities/login.dart';
import 'package:work_assistent_mob/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<AuthToken> execute(Login login) async {
    final token = await repository.register(login);
    await repository.cacheAuthToken(token);
    return token;
  }
}