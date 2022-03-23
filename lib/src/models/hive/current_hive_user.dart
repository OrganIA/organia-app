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

  CurrentHiveUser(
      {required this.email, required this.token, required this.userId});
}
