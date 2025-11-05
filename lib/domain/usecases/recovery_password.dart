import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class RecoveryPassword {
  final LoginRepository repository;

  RecoveryPassword(this.repository);

  Future<String> call({
    required int temporaryId,
    required int code,
    required String password,
  }) async {
    return await repository.recoveryPassword(
      temporaryId: temporaryId,
      code: code,
      password: password,
    );
  }
}