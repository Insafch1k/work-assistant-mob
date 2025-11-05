import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class ClearToken {
  final LoginRepository repository;

  ClearToken(this.repository);

  Future<void> call() async {
    return await repository.clearToken();
  }
}