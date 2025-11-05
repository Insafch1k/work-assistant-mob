import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class ForgotPassword {
  final LoginRepository repository;

  ForgotPassword(this.repository);

  Future<int> call({required String email}) async {
    return await repository.forgotPassword(email: email);
  }
}