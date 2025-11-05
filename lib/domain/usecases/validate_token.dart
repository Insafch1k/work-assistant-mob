import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class ValidateToken {
  final LoginRepository repository;

  ValidateToken(this.repository);

  Future<bool> call(String token) async {
    return await repository.validateToken(token);
  }
}