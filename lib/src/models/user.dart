class User {
  int id;
  String email;
  int roleId;

  User({
    required this.id,
    required this.email,
    required this.roleId,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      id: parsedJson["id"],
      email: parsedJson["email"],
      roleId: parsedJson["role_id"],
    );
  }
}
