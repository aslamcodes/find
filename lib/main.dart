import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find/model/user_model.dart';
import 'package:find/pages/home.dart';
import 'package:find/pages/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserModel())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // ignore: empty_constructor_bodies
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        DocumentSnapshot dbUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        final Map<String, dynamic> userMap =
            dbUser.data() as Map<String, dynamic>;
        if (context.mounted) {
          context.read<UserModel>().userLoad(
              FindUser(username: userMap['username'], email: userMap['email']));
        }
      }
    });
    return MaterialApp(
      home: const HomePageWidget(),
      initialRoute: context.read<UserModel>().user == null ? '/login' : '/',
      title: "finds",
      routes: routeMap,
    );
  }
}
