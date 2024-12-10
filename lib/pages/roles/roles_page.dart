import 'package:aula_flutter_full08/models/role.dart';
import 'package:aula_flutter_full08/services/user_service.dart';
import 'package:flutter/material.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  List<Role> roles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRoles();
  }

  void fetchRoles() async {
    try {
      List<Role> fetchedRoles = await userService.getRoles();
      setState(() {
        roles = fetchedRoles;
        isLoading = false;
      });
    } catch (error) {
      print('Erro ao carregar roles: $error');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar as roles')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roles dos Usuários'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: roles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(roles[index].name),
            subtitle: Text('ID: ${roles[index].id}'),
          );
        },
      ),
    );
  }
}
