import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organia/src/models/user.dart';

class OrganIAAPIProvider {
  final String baseUrl =
      "http://organia.francecentral.cloudapp.azure.com:8000/api/";
  final int success = 200;
  final int unauthorized = 401;
  final int unprocessable = 422;
  final int serverError = 500;
  Future<User> login() async {
    final response = await http.get(Uri.parse("$baseUrl/auth"));
    return parseLoginResponse(response);
  }

  Future<User> parseLoginResponse(http.Response response) async {
    final parsedResponse = json.decode(response.body);
    if (response.statusCode == success) {
      return User.fromJson(parsedResponse);
    } else if (response.statusCode == unprocessable) {
      throw Exception(parsedResponse["detail"]);
    } else {
      throw Exception("Unkown error");
    }
  }
}
