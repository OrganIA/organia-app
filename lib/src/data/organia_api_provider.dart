import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/hive/current_hive_user.dart';
import 'package:organia/src/models/message.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/utils/myhive.dart';

class OrganIAAPIProvider {
  // final String baseUrl =
  //     "http://organia.francecentral.cloudapp.azure.com:8000/api";
  final String baseUrl = "http://10.0.2.2:8000/api";
  final int success = 200;
  final int successPost = 201;
  final int unauthorized = 401;
  final int unprocessable = 422;
  final int serverError = 500;

  Future<User> login(String email, String password) async {
    if (email == "" || password == "") {
      throw Exception("Email ou mot de passe non fournis");
    }
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/auth/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    return parseLoginResponse(response);
  }

  Future<User> parseLoginResponse(http.Response response) async {
    if (response.statusCode == success) {
      final parsedBody = json.decode(response.body);
      await hive.box.put(
        "currentHiveUser",
        CurrentHiveUser(
          email: parsedBody["user"]["email"],
          token: parsedBody["token"],
          userId: parsedBody["user"]["id"],
        ),
      );
      return User.fromJson(parsedBody["user"]);
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

  Future<void> register(String email, String password) async {
    if (email == "" || password == "") {
      throw Exception("Email ou mot de passe non fournis");
    }
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/users/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password, "role_id": 0}),
    );
    return parseRegisterResponse(response);
  }

  Future<void> parseRegisterResponse(http.Response response) async {
    if (response.statusCode == successPost) {
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
        chatsList.add(
          Chat.fromJson(
            i,
            latestMessages.firstWhereOrNull(
              (message) => message.chatId == i["chat_id"],
            ),
          ),
        );
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
        messagesList.add(Message.fromJson(i));
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
      Uri.parse("$baseUrl/users"),
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
          "chat_name": chatName,
          "users_ids": userList,
        },
      ),
    );
    if (response.statusCode != successPost) {
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
          "chat_name": chatName,
          "users_ids": userList,
        },
      ),
    );
    if (response.statusCode != successPost) {
      throw Exception("Erreur ${response.statusCode}");
    }
    return;
  }

  List<dynamic> generateUsersList(List<User> users) {
    final List<dynamic> userList = [];
    for (var element in users) {
      userList.add({"user_id": element.id});
    }
    userList.add({"user_id": hive.box.get("currentHiveUser").userId});
    return userList;
  }
}
