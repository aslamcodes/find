import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FindUser {
  final String? username;
  final String? email;

  const FindUser({this.username, this.email});
}

class UserModel with ChangeNotifier {
  FindUser? user;

  void userLoad(FindUser user) {
    user = user;
    notifyListeners();
  }
}
