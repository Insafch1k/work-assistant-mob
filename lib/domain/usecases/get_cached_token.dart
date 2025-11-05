import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class GetCachedToken {
  final LoginRepository repository;

  GetCachedToken(this.repository);

  Future<String?> call() async {
    return await repository.getCachedToken();
  }
}