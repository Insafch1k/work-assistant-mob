import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class RecoveryCode {
  final LoginRepository repository;

  RecoveryCode(this.repository);

  Future<bool> call({required int temporaryId, required int code}) async {
    return await repository.recoveryCode(
      temporaryId: temporaryId,
      code: code,
    );
  }
}