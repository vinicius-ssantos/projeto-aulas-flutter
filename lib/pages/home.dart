import 'package:aula_flutter_full08/pages/create_user.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void goToCreateUser(context) {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => const CreateUserPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => goToCreateUser(context),
          )
        ],
      ),
      body: const Placeholder(),
    );
  }
}