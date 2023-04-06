import 'package:find/authentication/auth_controller.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final AuthController _authController = AuthController();
  late TextEditingController usernameController, passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const Text('username'),
      TextField(
        controller: usernameController,
      ),
      const Text('password'),
      TextField(
        controller: passwordController,
      ),
      TextButton(
          onPressed: () {
            _authController.login(
                usernameController.text, passwordController.text);
          },
          child: const Text("Login")),
      TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text("Register"))
    ]));
  }
}
