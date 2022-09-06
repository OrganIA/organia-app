import 'package:hive/hive.dart';
part 'current_hive_user.g.dart';

@HiveType(typeId: 1)
class CurrentHiveUser {
  @HiveField(0)
  String email;
  @HiveField(1)
  String token;
  @HiveField(2)
  int userId;
  @HiveField(3)
  String firstName;
  @HiveField(4)
  String lastName;
  @HiveField(5)
  String phoneNumber;
  @HiveField(6)
  String countryCode;

  CurrentHiveUser({
    required this.email,
    required this.token,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.countryCode,
  });
}
