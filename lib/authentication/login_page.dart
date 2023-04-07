import 'package:find/authentication/auth_controller.dart';
import 'package:find/widgets/common/find_elevated_button.dart';
import 'package:find/widgets/common/find_text_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final AuthController _authController = AuthController();
  late TextEditingController usernameController, passwordController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  void _showErrorSnackbar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.blueGrey,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Login",
        style: GoogleFonts.lobster(
            textStyle: const TextStyle(
          fontSize: 35,
          color: Color.fromRGBO(0, 129, 159, 1),
        )),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            FindTextInput(
                controller: usernameController, label: "Your Lovely Username"),
            SizedBox(height: 10),
            FindTextInput(
                controller: passwordController, label: "Your Password"),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FindElevatedButton(
              onClick: () async {
                setState(() {
                  _isLoading = true;
                });
                try {
                  await _authController.login(
                      usernameController.text, passwordController.text);
                  setState(() {
                    _isLoading = false;
                  });
                } catch (e) {
                  setState(() {
                    _isLoading = false;
                  });
                  _showErrorSnackbar(e.toString(), context);
                }
              },
              child: _isLoading
                  ? CircularProgressIndicator()
                  : const Text("Login")),
          SizedBox(width: 10),
          FindElevatedButton(
              onClick: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text("Register")),
        ],
      )
    ]));
  }
}
