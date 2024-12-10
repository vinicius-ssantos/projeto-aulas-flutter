import 'dart:convert';

import 'package:aula_flutter_full08/models/user.dart';
import 'package:aula_flutter_full08/services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../models/Role.dart';

class UserService {

  final String _baseUrl = 'http://192.168.1.104:3030/users';

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


  Future<User> update(User user) async {
      final response = await http.put(
          Uri.parse('$_baseUrl/${user.id}'),
          headers: _getHeaders(),
          body: jsonEncode(user.toObject())
      );
      if (response.statusCode == 200) {
        print('RESPONSE BODY SUCESSO ${response.body}');
        return User.fromObject(jsonDecode(response.body));
      }else{
        print('RESPONSE BODY ERRO  ${response.body}');
        throw Exception('Erro ao atualizar o usuário!');
      }
  }

  Future<bool> delete(User user) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/${user.id}'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      // Retorna true se a exclusão foi bem-sucedida
      return true;
    } else if (response.statusCode == 404) {
      // Caso o usuário não seja encontrado
      throw Exception('Usuário não encontrado!');
    } else if (response.statusCode == 403) {
      // Caso não tenha permissão
      throw Exception('Você não tem permissão para excluir este usuário!');
    } else {
      // Outros erros
      throw Exception('Erro ao excluir o usuário!');
    }
  }

  
  Future<List<Role>> getRoles() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/roles'), // Atualize o endpoint de acordo com seu backend
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      List<dynamic> list = List.from(jsonDecode(response.body));
      return list.map((e) => Role.fromObject(e)).toList();
    } else {
      throw Exception('Erro ao buscar as roles!');
    }
  }
}

final userService = UserService();
