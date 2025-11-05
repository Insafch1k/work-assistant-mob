import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class ConfirmMail {
  final LoginRepository repository;

  ConfirmMail(this.repository);

  Future<String> call({required int temporaryId, required int code}) async {
    return await repository.confirmMail(
      temporaryId: temporaryId,
      code: code,
    );
  }
}