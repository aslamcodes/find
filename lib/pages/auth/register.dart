import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<void> _uploadProfilePicture(String uid) async {
    if (_imageFile == null) return;
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('users/$uid/profile.jpg');
    final UploadTask uploadTask = storageRef.putFile(_imageFile!);
    await uploadTask.whenComplete(() => null);
  }

  void registerHandler() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (credential.user?.uid != null) {
        await _uploadProfilePicture(credential.user!.uid);

        await FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid)
            .set({
          "username": usernameController.text,
          "email": emailController.text,
          'profile_picture': 'users/${credential.user?.uid}/profile.jpg'
        });
      }

      if (context.mounted) {
        Navigator.pushNamed(context, '/');
      }
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
