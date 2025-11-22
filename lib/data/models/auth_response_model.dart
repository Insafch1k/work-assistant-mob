class AuthResponseModel {
  final String? token;
  final String? message;
  final String? role;
  final int? temporaryId;
  final String? userName;
  final String? email;

  AuthResponseModel({
    this.token,
    this.message,
    this.role,
    this.temporaryId,
    this.userName,
    this.email,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    print('JSON: $json');

    return AuthResponseModel(
      token: json['token'] ?? json['access_token'],
      message: json['message'],
      role: json['role']?.toString(),
      temporaryId: json['temporary_id'],
      userName: json['user_name'],
      email: json['email'],
    );
  }

  String? get resolvedRole => role;

  Map<String, dynamic> toJson() {
    return {
      if (token != null) 'token': token,
      if (message != null) 'message': message,
      if (role != null) 'role': role,
      if (temporaryId != null) 'temporary_id': temporaryId,
      if (userName != null) 'user_name': userName,
      if (email != null) 'email': email,
    };
  }
}