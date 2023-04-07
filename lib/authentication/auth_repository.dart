import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  const AuthRepository();
  Future<void> login(Map<String, dynamic> userValues) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userValues['username'],
        password: userValues['password'],
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw Exception('An error occurred while logging in.');
      }
    } catch (e) {
      throw Exception('An error occurred while logging in.');
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
      } else {
        throw Exception("User could not be created");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
