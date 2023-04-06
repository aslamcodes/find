import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  Future<void> login(Map<String, dynamic> userValues) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userValues['username'], password: userValues['password']);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> register(Map<String, dynamic> userValues) async {
    Future<String?> uploadProfilePicture(
        String fileName, File? imageFile) async {
      if (imageFile == null) return null;
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('users/$fileName/profile.jpg');
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      await uploadTask.whenComplete(() => null);
      final String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    }

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userValues['email'],
        password: userValues['password'],
      );

      if (credential.user != null) {
        final String? profileUrl = await uploadProfilePicture(
            credential.user!.uid, userValues['profileImage']);

        await FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid)
            .set({
          "username": userValues['email'],
          "email": userValues['password'],
          'profile_picture': profileUrl
        });
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
}
