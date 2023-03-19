import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  int counter = 0;
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const Text('username'),
      const TextField(),
      const Text('password'),
      const TextField(),
      TextButton(onPressed: () {}, child: const Text("Login")),
      TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text("Register"))
    ]));
  }
}
