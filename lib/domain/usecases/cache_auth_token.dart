import 'package:work_assistent_mob/domain/repositories/login_repository.dart';

class CacheAuthToken {
  final LoginRepository repository;

  CacheAuthToken(this.repository);

  Future<void> call(String token) async {
    return await repository.cacheAuthToken(token);
  }
}