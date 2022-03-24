import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/hive/current_hive_user.dart';
import 'package:organia/src/models/message.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/utils/myhive.dart';

class OrganIAAPIProvider {
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
    final response = await http.post(
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
    final response = await http.get(
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
    final response = await http.post(
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

  Future<List<Chat>> getUserChats() async {
    final response = await http.get(
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
      List<Chat> chatsList = [];
      final parsedBody = json.decode(response.body);
      for (var i in parsedBody) {
        chatsList.add(Chat.fromJson(i));
      }
      return chatsList;
    } else {
      throw Exception("Erreur inconnue");
    }
  }

  Future<List<Message>> getChatMessages(int chatId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/chats/messages/$chatId"),
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

  Future<List<User>> getChatUsers(List<int> usersIds) async {
    List<User> users = [];
    for (var element in usersIds) {
      final response = await http.get(
        Uri.parse("$baseUrl/users/$element"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${hive.box.get('currentHiveUser').token}"
        },
      );
      users.add(await parseUserInfosResponse(response));
    }
    return users;
  }
}
