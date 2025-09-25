class UserEntity {
  final String userName;

  UserEntity({required this.userName});

  @override
  String toString() => 'UserEntity(userName: $userName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserEntity && other.userName == userName;
  }

  @override
  int get hashCode => userName.hashCode;
}