import 'package:organia/src/data/organia_api_provider.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/user.dart';

class OrganIAAPIRepository {
  final OrganIAAPIProvider _organIAAPIProvider = OrganIAAPIProvider();

  Future<User> login(String email, String password) =>
      _organIAAPIProvider.login(email, password);

  Future<User> geMyInfos(String token) => _organIAAPIProvider.getMyInfos(token);

  Future<void> register(String email, String password) =>
      _organIAAPIProvider.register(email, password);

  Future<List<Chat>> getUserChats() => _organIAAPIProvider.getUserChats();
}
