import 'package:aula_flutter_full08/models/user.dart';
import 'package:aula_flutter_full08/pages/user/create_user.dart';
import 'package:aula_flutter_full08/services/user_service.dart';
import 'package:flutter/material.dart';

import 'user/edit_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  void loadUsers() {
    userService.getList().then((data) {
      setState(() {
        users = data;
      });
    }).catchError((error) {
      users.forEach((user) {
        print(
            'LOAD-USERS ---- FALHA Nome: ${user.name} ${user.password} ${user.token}');
      });
    });
  }

  Future<List<User>> fetchUsers(BuildContext context) async {
    try {
      return await userService.getList();
    } catch (error) {
      Navigator.pop(context);
    }
    return [];
  }

  void goToCreateUser(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CreateUserPage()),
        ).then((newUser) {
      if (newUser != null) {
        addUserToList(newUser);
      }
    }
    );
  }
  void addUserToList(User newUser) {
    setState(() {
      users.add(newUser); // Adiciona o usuário à lista local
    });
  }

  void updateUserInList(User updatedUser) {
    setState(() {
      final index = users.indexWhere((user) => user.id == updatedUser.id);
      if (index != -1) {
        users[index] = updatedUser; // Atualiza o registro na lista
      }
    });
  }

  void deleteUser(User user) {
    userService.delete(user).then((isDeleted) {
      if (isDeleted) {
        setState(() {
          users
              .removeWhere((u) => u.id == user.id); // Remove o usuário da lista
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário ${user.name} deletado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao deletar o usuário ${user.name}!')),
        );
      }
    }).catchError((error) {
      print('Erro ao deletar usuário: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao deletar o usuário ${user.name}!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários'), actions: [
        IconButton(
          icon: const Icon(Icons.person_add),
          onPressed: () => goToCreateUser(context),
        )
      ]),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(users[index].name), // Nome do usuário
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUserPage(user: users[index]),
                      ),
                    ).then((updatedUser) {
                      if (updatedUser != null) {
                        updateUserInList(
                            updatedUser); // Atualiza o usuário na lista
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteUser(users[index]), // deleta o usuário
                ),
              ]));
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Usuários'),
  //       actions: [
  //         IconButton(
  //           icon: const Icon(Icons.person_add),
  //           onPressed: () => goToCreateUser(context),
  //         )
  //       ],
  //     ),
  //     body: FutureBuilder(
  //       future: fetchUsers(context),
  //       builder: (context, snapshot) {
  //         List<User> users = snapshot.data ?? [];
  //         return RefreshIndicator(
  //           onRefresh: () {
  //             setState(() {});
  //             return Future.value();
  //           },
  //           child: _buildListUsers(users),
  //         );
  //       }
  //     ),
  //   );
  // }

  ListView _buildListUsers(List<User> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          User user = users[index];

          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.username),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditUserPage(user: user)));
              },
            ),
          );
        });
  }
}
