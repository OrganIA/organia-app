class User {
  int id;
  String email;
  int roleId;
  String firstName;
  String lastName;
  String phoneNumber;
  String countryCode;

  User({
    required this.id,
    required this.email,
    required this.roleId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.countryCode,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      id: parsedJson["id"],
      email: parsedJson["email"],
      roleId: parsedJson["role_id"],
      firstName: parsedJson["firstname"],
      lastName: parsedJson["lastname"],
      phoneNumber: parsedJson["phone_number"],
      countryCode: "FR",
    );
  }
}
