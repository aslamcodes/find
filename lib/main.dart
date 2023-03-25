import 'package:find/classes/find_user.dart';
import 'package:find/model/user_model.dart';
import 'package:find/pages/home.dart';
import 'package:find/pages/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Print Working");
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      initialData: null,
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FindUser? user = context.read<UserProvider>().currentUser;
    return MaterialApp(
      home: const HomePageWidget(),
      initialRoute: user != null ? '/' : '/login',
      title: "finds",
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: routeMap,
    );
  }
}
