import 'package:work_assistent_mob/domain/entities/login.dart';
import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class RegisterMail {
  final LoginRepository repository;

  RegisterMail(this.repository);

  Future<int> call(Login login) async {
    return await repository.registerMail(login);
  }
}