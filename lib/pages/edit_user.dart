import 'package:aula_flutter_full08/components/my_button.dart';
import 'package:aula_flutter_full08/components/my_input.dart';
import 'package:aula_flutter_full08/models/user.dart';
import 'package:aula_flutter_full08/pages/login.dart';
import 'package:aula_flutter_full08/services/user_service.dart';
import 'package:aula_flutter_full08/util.dart';
import 'package:flutter/material.dart';

class EditUserPage extends StatefulWidget {
  final User user;

  const EditUserPage({super.key, required this.user});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late String _name;
  late String _username;


  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _username = widget.user.username;

  }

  void update() {
    if (_name.trim().isEmpty) {
      Util.alert(context, 'Nome é obrigatório!');
      return;
    }


    final User userToUpdate = User(widget.user.id, _name, _username, widget.user.password);

      userService.update(userToUpdate).then((updatedUser) {
        if (updatedUser != null) {
          print('EDIT-USER Usuário atualizado com sucesso! ${userToUpdate.name} ${userToUpdate.username} ${userToUpdate.password}');
          Navigator.pop(context, updatedUser); // Retorna o usuário atualizado
        } else {
          print('Erro ao atualizar o usuário!');
          Util.alert(context, 'Erro ao atualizar o usuário!');
        }
      }).catchError((error) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Usuário')),
      body: Column(
        children: [
          MyInput(
            label: 'Nome',
            initialValue: _name,
            change: (String value) => _name = value,
          ),
          MyButton(text: 'Atualizar', onPress: update),
        ],
      ),
    );
  }
}
