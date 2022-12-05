class User {
  int id;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String countryCode;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.countryCode,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      id: parsedJson["id"],
      email: parsedJson["email"],
      firstName: parsedJson["firstname"],
      lastName: parsedJson["lastname"],
      phoneNumber: parsedJson["phone_number"],
      countryCode: "FR",
    );
  }
}
