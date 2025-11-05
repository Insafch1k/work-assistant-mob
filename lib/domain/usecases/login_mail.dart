import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class LoginMail {
  final LoginRepository repository;

  LoginMail(this.repository);

  Future<Map<String, dynamic>> call({required String email, required String password}) async {
    return await repository.loginMail(
      email: email,
      password: password,
    );
  }
}