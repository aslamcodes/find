import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Register> {
  final usernameController = TextEditingController(),
      passwordController = TextEditingController(),
      emailController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  void registerHandler() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user?.uid)
          .set({
        "username": usernameController.text,
        "email": emailController.text,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(children: [
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
