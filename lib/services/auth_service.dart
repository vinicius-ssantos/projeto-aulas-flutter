import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:aula_flutter_full08/models/user.dart';


class AuthService {

  final String _baseUrl = 'http://192.168.0.12:3030/auth/login';

  Future<User?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({ 'username': username, 'password': password })
    );

    if (response.statusCode == 201) {
      dynamic obj = jsonDecode(response.body);
      final user = User.fromObject(obj);

      print(user.token);
      return user;
    }
    return null;
  }

}