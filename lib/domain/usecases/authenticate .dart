import 'package:work_assistent_mob/domain/entities/login.dart';
import 'package:work_assistent_mob/domain/repositories/login_repository.dart';


class Authenticate {
  final LoginRepository repository;

  Authenticate(this.repository);

  Future<String> call(Login login) async {
    return await repository.authenticate(login);
  }
}