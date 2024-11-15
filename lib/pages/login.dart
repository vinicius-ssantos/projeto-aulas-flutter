import 'package:aula_flutter_full08/components/my_input.dart';
import 'package:aula_flutter_full08/pages/home.dart';
import 'package:aula_flutter_full08/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();
  String _username = '';
  String _password = '';

  void alert(String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK')
          )
        ],
      )
    );
  }

  Future<void> signIn() async {
    final logged = await authService.login(_username, _password);
    if (logged == null) {
      alert('Login/senha inválido(a)!');
    } else {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const HomePage())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acesso')),
      body: Column(
        children: [
          MyInput(
            label: 'Login',
            change: (value) => _username = value,
          ),
          MyInput(
            label: 'Senha',
            obscureText: true,
            change: (value) => _password = value,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Entrar'),
                onPressed: signIn,
              ),
            ),
          )
        ],
      )
    );
  }
}