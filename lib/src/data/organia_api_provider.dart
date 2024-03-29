import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/hive/current_hive_user.dart';
import 'package:organia/src/models/message.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/utils/myhive.dart';

class OrganIAAPIProvider {
  final String baseUrl = "https://dev.organia.savatier.fr/api";
  // final String baseUrl = "http://localhost:8000/api";
  final int success = 200;
  final int successCreated = 201;
  final int successNoContent = 204;
  final int unauthorized = 401;
  final int unprocessable = 422;
  final int serverError = 500;

  Future<User> login(String email, String password) async {
    if (email == "" || password == "") {
      throw Exception("Email ou mot de passe non fournis");
    }
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    return parseLoginResponse(response);
  }

  Future<User> parseLoginResponse(http.Response response) async {
    if (response.statusCode == success) {
      final parsedBody = json.decode(response.body);
      final User user = User.fromJson(parsedBody["user"]);
      await hive.box.put(
        "currentHiveUser",
        CurrentHiveUser(
          email: user.email,
          token: parsedBody["token"],
          userId: user.id,
          firstName: user.firstName,
          lastName: user.lastName,
          phoneNumber: user.phoneNumber,
          countryCode: user.countryCode,
        ),
      );
      return user;
    } else if (response.statusCode == unprocessable) {
      throw Exception("Utilisateur inconnu");
    } else if (response.statusCode == unauthorized) {
      throw Exception("Mot de passe incorrect");
    } else {
      throw Exception("Erreur inconnue");
    }
  }

  Future<User> getMyInfos() async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/users/me"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${hive.box.get('currentHiveUser').token}"
      },
    );
    return parseUserInfosResponse(response);
  }

  Future<User> parseUserInfosResponse(http.Response response) async {
    if (response.statusCode == success) {
      final parsedBody = json.decode(response.body);
      return User.fromJson(parsedBody);
    } else if (response.statusCode == unprocessable) {
      throw Exception("Connexion automatique impossible");
    } else {
      throw Exception("Erreur inconnue");
    }
  }

  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String countryCode,
  ) async {
    if (email == "" ||
        password == "" ||
        firstName == "" ||
        lastName == "" ||
        phoneNumber == "" ||
        countryCode == "") {
      throw Exception("Un champ n'a pas été fourni.");
    }
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "email": email,
          "password": password,
          "role_id": 0,
          "firstname": firstName,
          "lastname": lastName,
          "phone_number": phoneNumber,
        },
      ),
    );
    return parseRegisterResponse(response);
  }

  Future<void> parseRegisterResponse(http.Response response) async {
    if (response.statusCode == successCreated) {
      return;
    } else if (response.statusCode == unprocessable) {
      throw Exception("Adresse email déjà utilisée");
    } else {
      throw Exception("Erreur inconnue");
    }
  }

  Future<List<Chat>> getChats() async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/chats/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${hive.box.get('currentHiveUser').token}"
      },
    );
    return parseChatsListResponse(response);
  }

  Future<List<Chat>> parseChatsListResponse(http.Response response) async {
    if (response.statusCode == success) {
      final List<Message> latestMessages = await getLatestMessagesOfChats();
      final List<Chat> chatsList = [];
      final parsedBody = json.decode(response.body);
      for (var i in parsedBody) {
        final Chat chat = Chat.fromJson(
          i,
          latestMessages.firstWhereOrNull(
            (message) => message.chatId == i["id"],
          ),
        );
        chatsList.add(chat);
      }
      return chatsList;
    } else {
      throw Exception("Erreur inconnue");
    }
  }

  Future<List<Message>> getLatestMessagesOfChats() async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/chats/messages/latest"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${hive.box.get('currentHiveUser').token}"
      },
    );
    return parseMessagesListResponse(response);
  }

  Future<List<Message>> getChatMessages(int chatId) async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/chats/$chatId/messages"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${hive.box.get('currentHiveUser').token}"
      },
    );
    return parseMessagesListResponse(response);
  }

  Future<List<Message>> parseMessagesListResponse(
    http.Response response,
  ) async {
    if (response.statusCode == success) {
      List<Message> messagesList = [];
      final parsedBody = json.decode(response.body);
      for (var i in parsedBody) {
        final Message message = Message.fromJson(i);
        messagesList.add(message);
      }
      return messagesList;
    } else {
      throw Exception("Erreur inconnue");
    }
  }

  Future<Chat> getChat(int chatId) async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/chats/$chatId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${hive.box.get('currentHiveUser').token}"
      },
    );
    return parseChatResponse(response);
  }

  Chat parseChatResponse(http.Response response) {
    final parsedBody = json.decode(response.body);
    return Chat.fromJson(parsedBody, null);
  }

  Future<List<User>> getChatUsers(List<int> usersIds) async {
    List<User> users = [];
    for (var userId in usersIds) {
      final http.Response response = await http.get(
        Uri.parse("$baseUrl/users/$userId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${hive.box.get('currentHiveUser').token}"
        },
      );
      users.add(await parseUserInfosResponse(response));
    }
    return users;
  }

  Future<List<User>> getAllUsers() async {
    final List<User> users = [];
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/users/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${hive.box.get('currentHiveUser').token}"
      },
    );
    if (response.statusCode == success) {
      final parsedBody = json.decode(response.body);
      for (var element in parsedBody) {
        users.add(User.fromJson(element));
      }
    } else {
      throw Exception("Erreur ${response.statusCode}");
    }
    return users;
  }

  Future<void> createChat(String chatName, List<User> users) async {
    if (chatName == "") {
      throw Exception("Aucun nom fourni");
    } else if (users.isEmpty) {
      throw Exception("Aucun utilisateur ajouté");
    }
    final List<dynamic> userList = generateUsersList(users);
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/chats/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${hive.box.get('currentHiveUser').token}"
      },
      body: jsonEncode(
        {
          "name": chatName,
          "users_ids": userList,
        },
      ),
    );
    if (response.statusCode != success) {
      throw Exception("Erreur ${response.statusCode}");
    }
    return;
  }

  Future<void> editChat(String chatName, List<User> users, int chatId) async {
    if (chatName == "") {
      throw Exception("Aucun nom fourni");
    } else if (users.isEmpty) {
      throw Exception("Aucun utilisateur ajouté");
    }
    final List<dynamic> userList = generateUsersList(users);
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/chats/$chatId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${hive.box.get('currentHiveUser').token}"
      },
      body: jsonEncode(
        {
          "name": chatName,
          "users_ids": userList,
        },
      ),
    );
    if (response.statusCode != success) {
      throw Exception("Erreur ${response.statusCode}");
    }
    return;
  }

  List<dynamic> generateUsersList(List<User> users) {
    final List<int> userList = [];
    for (var element in users) {
      userList.add(element.id);
    }
    userList.add(hive.box.get("currentHiveUser").userId);
    return userList;
  }

  Future<void> deleteChat(int chatId) async {
    final http.Response response = await http.delete(
      Uri.parse("$baseUrl/chats/$chatId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${hive.box.get('currentHiveUser').token}"
      },
    );
    if (response.statusCode != successNoContent) {
      throw Exception("Erreur ${response.statusCode}");
    }
    return;
  }
}
