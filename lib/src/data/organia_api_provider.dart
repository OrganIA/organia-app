import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organia/src/models/chat.dart';
import 'package:organia/src/models/message.dart';
import 'package:organia/src/models/user.dart';
import 'package:organia/src/utils/shared_preferences.dart';

class OrganIAAPIProvider {
  final String baseUrl = "http://10.0.2.2:8000/api";
  final int success = 200;
  final int successPost = 201;
  final int unauthorized = 401;
  final int unprocessable = 422;
  final int serverError = 500;

  Future<User> login(String email, String password) async {
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
      await MySharedPreferences().set("TOKEN", parsedBody["token"]);
      await MySharedPreferences()
          .set("USER_ID", parsedBody["user"]["id"].toString());
      return User.fromJson(parsedBody["user"]);
    } else if (response.statusCode == unprocessable) {
      throw Exception("Utilisateur inconnu");
    } else {
      throw Exception("Erreur inconnue");
    }
  }

  Future<User> getMyInfos(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/users/me"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
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
      throw Exception("Email ou mot de passe non fourni");
    } else {
      throw Exception("Erreur inconnue");
    }
  }

  Future<List<Chat>> getUserChats(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/chats/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
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

  Future<List<Message>> getChatMessages(String token, int id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/chats/messages/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    return parseMessagesListResponse(response);
  }

  Future<List<Message>> parseMessagesListResponse(
      http.Response response) async {
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
}
