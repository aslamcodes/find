import 'dart:io';
import 'package:find/authentication/auth_controller.dart';
import 'package:find/widgets/common/find_elevated_button.dart';
import 'package:find/widgets/common/find_text_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final AuthController _authController = const AuthController();

  bool _isLoading = false;
  String? _errorText;
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
    setState(() {
      _isLoading = true;
      _errorText = null;
    });
    try {
      await _authController.register(usernameController.text,
          passwordController.text, emailController.text, _imageFile);
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorText = error.toString();
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(_buildErrorSnackBar(context, _errorText));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(children: [
        Container(
          margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Register",
                style: GoogleFonts.lobster(
                    textStyle: const TextStyle(
                  fontSize: 35,
                  color: Color.fromRGBO(0, 129, 159, 1),
                )),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  maxRadius: 50,
                  minRadius: 50,
                  foregroundImage: (_imageFile == null)
                      ? const AssetImage("assets/upload_avatar.png")
                      : FileImage(_imageFile!) as ImageProvider<Object>?,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FindTextInput(
                controller: usernameController,
                label: 'username',
              ),
              const SizedBox(height: 10),
              FindTextInput(
                controller: emailController,
                label: 'email',
              ),
              const SizedBox(height: 10),
              FindTextInput(controller: passwordController, label: 'password'),
            ],
          ),
        ),
        Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : FindElevatedButton(
                  onClick: () {
                    registerHandler();
                    Navigator.pop(context);
                  },
                  child: const Text("Register")),
        )
      ])),
    );
  }
}

SnackBar _buildErrorSnackBar(BuildContext context, String? errorText) {
  return SnackBar(
    content: Text(
      errorText ?? 'An error occurred!',
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.blueGrey,
  );
}
