import 'package:work_assistent_mob/domain/entities/login.dart';

class LoginModel {
  final String user_name;
  final String email;
  final String password;
  final String user_role;

  LoginModel({
    required this.user_name,
    required this.email,
    required this.password,
    required this.user_role,
  });

  factory LoginModel.fromEntity(Login entity) {
    return LoginModel(
      user_name: entity.user_name,
      email: entity.email,
      password: entity.password,
      user_role: entity.user_role,
    );
  }

  Login toEntity() {
    return Login(
      user_name: user_name,
      email: email,
      password: password,
      user_role: user_role,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': user_name,
      'email': email,
      'password': password,
      'user_role': user_role,
    };
  }

  // Для смены пароля
  Map<String, dynamic> toChangePasswordJson() {
    return {
      'old_password': password, // здесь password будет старым паролем
      'new_password': user_name, // здесь user_name будет новым паролем
    };
  }

  // Для восстановления пароля
  Map<String, dynamic> toRecoveryJson({required int code, required int temporaryId}) {
    return {
      'temporary_id': temporaryId,
      'code': code,
      'password': password,
    };
  }
}