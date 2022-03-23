import 'package:organia/src/data/organia_api_provider.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/message.dart';
import 'package:organia/src/models/user.dart';

class OrganIAAPIRepository {
  final OrganIAAPIProvider _organIAAPIProvider = OrganIAAPIProvider();

  Future<User> login(String email, String password) =>
      _organIAAPIProvider.login(email, password);

  Future<User> geMyInfos() => _organIAAPIProvider.getMyInfos();

  Future<void> register(String email, String password) =>
      _organIAAPIProvider.register(email, password);

  Future<List<Chat>> getUserChats() => _organIAAPIProvider.getUserChats();

  Future<List<Message>> getChatMessages(int chatId) =>
      _organIAAPIProvider.getChatMessages(chatId);

  Future<List<User>> getChatUsers(List<int> usersIds) =>
      _organIAAPIProvider.getChatUsers(usersIds);
}
