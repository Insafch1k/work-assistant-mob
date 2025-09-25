import 'package:work_assistent_mob/data/datasources/local/auth_local_data_source.dart';
import 'package:work_assistent_mob/data/datasources/remote/login_remote_data_source.dart';
import 'package:work_assistent_mob/data/models/login_model.dart';
import 'package:work_assistent_mob/domain/entities/login.dart';
import 'package:work_assistent_mob/domain/repositories/login_repository.dart';
import 'package:work_assistent_mob/presentation/providers/auth_provider.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final AuthProvider authProvider; 

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.authProvider,
  });

  @override
  Future<String> authenticate(Login login) async {
    try {
      final loginModel = LoginModel.fromEntity(login);
      final response = await remoteDataSource.authenticate(loginModel);

      await localDataSource.saveToken(response.token);
      authProvider.updateToken(response.token); 

      return response.token;
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<void> clearToken() {
    throw UnimplementedError();
  }
  
  @override
  Future<String?> getCachedToken() {
    throw UnimplementedError();
  }
}
