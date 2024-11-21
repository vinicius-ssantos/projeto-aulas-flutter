import 'dart:convert';

import 'package:aula_flutter_full08/models/user.dart';
import 'package:aula_flutter_full08/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UserService {

  final String _baseUrl = 'http://192.168.0.12:3030/users';

  final AuthService _authService = AuthService();

  Future<bool> create(User user) async {
    User? session = _authService.getSession();
    if (session == null || session.token == null) throw Exception('Sessão expirada!');

    var response;

    try {
      response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${session.token}'
        },
        body: jsonEncode(user.toObject())
      );
    } catch(error) {
      print('Error: $error');
    }

    print('Status: ${response.statusCode}');

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