import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organia/src/models/user.dart';
import 'package:organia/src/utils/shared_preferences.dart';

class OrganIAAPIProvider {
  final String baseUrl =
      "http://organia.francecentral.cloudapp.azure.com:8000/api";
  final int success = 200;
  final int successPost = 201;
  final int unauthorized = 401;
  final int unprocessable = 422;
  final int serverError = 500;

  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/"),
      body: jsonEncode(
        <String, String>{'email': email, 'password': password},
      ),
    );
    return parseLoginResponse(response);
  }

  Future<User> parseLoginResponse(http.Response response) async {
    if (response.statusCode == success) {
      final parsedResponse = json.decode(response.body);
      await MySharedPreferences().set("TOKEN", parsedResponse["token"]);
      return User.fromJson(parsedResponse["user"]);
    } else if (response.statusCode == unprocessable) {
      throw Exception("Utilisateur inconnu");
    } else {
      throw Exception("Erreur inconnue");
    }
  }

  Future<bool> register(String email, String password) async {
    Map data = {"email": email, "password": password, "role_id": 0};

    final response = await http.post(
      Uri.parse("$baseUrl/users/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    return parseRegisterResponse(response);
  }

  Future<bool> parseRegisterResponse(http.Response response) async {
    if (response.statusCode == successPost) {
      return true;
    } else if (response.statusCode == unprocessable) {
      throw Exception("Email ou mot de passe non fourni");
    } else {
      throw Exception("Erreur inconnue");
    }
  }
}
