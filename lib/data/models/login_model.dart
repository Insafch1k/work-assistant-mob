import 'package:work_assistent_mob/domain/entities/login.dart';

class LoginModel {
  final String tg;
  final String tg_username;
  final String user_role;
  final String user_name;

  LoginModel({
    required this.tg,
    required this.tg_username,
    required this.user_role,
    required this.user_name,
  });

  factory LoginModel.fromEntity(Login entity) {
    return LoginModel(
      tg: entity.tg,
      tg_username: entity.tg_username,
      user_role: entity.user_role,
      user_name: entity.user_name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tg' : tg,
      'tg_username': tg_username,
      'user_role': user_role,
      'user_name': user_name,
    };
  }

}
