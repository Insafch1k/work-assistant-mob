import 'package:work_assistent_mob/data/models/auth_response_model.dart';
import 'package:work_assistent_mob/data/models/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> register(LoginModel login);
}