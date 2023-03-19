import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<Register> {
  final usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
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
      const TextField(),
      TextButton(onPressed: () {}, child: const Text("Register"))
    ]));
  }
}
