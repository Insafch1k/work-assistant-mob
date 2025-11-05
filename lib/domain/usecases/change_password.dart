import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class ChangePassword {
  final LoginRepository repository;

  ChangePassword(this.repository);

  Future<Map<String, dynamic>> call({
    required String oldPassword,
    required String newPassword,
  }) async {
    return await repository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}