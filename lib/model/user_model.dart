import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find/interfaces/find_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late FirebaseFirestore _firestore;
  late CollectionReference _usersCollection;

  FindUser? _currentUser;

  FindUser? get currentUser => _currentUser;

  UserProvider() {
    _firestore = FirebaseFirestore.instance;
    _usersCollection = _firestore.collection('users');

    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser == null) {
        _currentUser = null;
        notifyListeners();
      } else {
        final userDoc = await _usersCollection.doc(firebaseUser.uid).get();

        if (userDoc.exists) {
          _currentUser =
              FindUser.fromJson(userDoc.data() as Map<String, dynamic>);
        } else {
          _currentUser = FindUser(
            // id: firebaseUser.uid,
            profileImage: '',
            username: firebaseUser.displayName ?? '',
            email: firebaseUser.email ?? '',
          );
          await _usersCollection
              .doc(firebaseUser.uid)
              .set(_currentUser!.toJson());
        }
        notifyListeners();
      }
    });
  }
}
