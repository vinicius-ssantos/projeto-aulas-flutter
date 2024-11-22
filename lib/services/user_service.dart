import 'dart:convert';

import 'package:aula_flutter_full08/models/user.dart';
import 'package:aula_flutter_full08/services/auth_service.dart';
import 'package:http/http.dart' as http;

class _UserService {

  final String _baseUrl = 'http://192.168.0.12:3030/users';

  Map<String, String> _getHeaders() {
    User? session = authService.getSession();
    if (session == null || session.token == null) throw Exception('Sessão expirada!');

    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${session.token}'
    };
  }

  Future<List<User>> getList() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: _getHeaders()
    );

    if (response.statusCode == 200) {
      List<dynamic> list = List.from(jsonDecode(response.body));
      List<User> users = list.map((e) => User.fromObject(e)).toList();
      return users;
    }

    throw Exception('Sessão expirada!');
  }

  Future<bool> create(User user) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: _getHeaders(),
      body: jsonEncode(user.toObject())
    );

    if (response.statusCode == 201) {
      dynamic obj = jsonDecode(response.body);
      User user = User.fromObject(obj);
      return (user.id != null);
    } else if (response.statusCode != 400) {
      throw Exception('Sessão expirada!');
    }

    return false;
  }
}

final userService = _UserService();