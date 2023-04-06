import 'dart:io';
import 'package:find/authentication/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Register> {
  final usernameController = TextEditingController(),
      passwordController = TextEditingController(),
      emailController = TextEditingController();
  final AuthController _authController = AuthController();
  File? _imageFile;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void registerHandler() async {
    await _authController.register(
        usernameController.text, passwordController.text, _imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(children: [
        TextButton(
          onPressed: _pickImage,
          child: const Text("Choose Profile Picture"),
        ),
        const Text('username'),
        TextField(
          controller: usernameController,
        ),
        const Text('email'),
        TextField(
          controller: emailController,
        ),
        const Text('password'),
        TextField(
          controller: passwordController,
        ),
        TextButton(onPressed: registerHandler, child: const Text("Register"))
      ])),
    );
  }
}
