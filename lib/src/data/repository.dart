import 'package:organia/src/data/organia_api_provider.dart';
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/message.dart';
import 'package:organia/src/models/user.dart';

class OrganIAAPIRepository {
  final OrganIAAPIProvider _organIAAPIProvider = OrganIAAPIProvider();

  Future<User> login(String email, String password) =>
      _organIAAPIProvider.login(email, password);

  Future<User> geMyInfos() => _organIAAPIProvider.getMyInfos();

  Future<List<User>> getAllUsers() => _organIAAPIProvider.getAllUsers();

  Future<void> register(String email, String password) =>
      _organIAAPIProvider.register(email, password);

  Future<List<Chat>> getChats() => _organIAAPIProvider.getChats();

  Future<void> createChat(String chatName, List<User> users) =>
      _organIAAPIProvider.createChat(chatName, users);

  Future<List<Message>> getChatMessages(int chatId) =>
      _organIAAPIProvider.getChatMessages(chatId);

  Future<List<User>> getChatUsers(List<int> usersIds) =>
      _organIAAPIProvider.getChatUsers(usersIds);
}
