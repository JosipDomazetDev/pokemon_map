import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> createUserIfNotExist(
      String username, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        return null;
      } else {
        return null;
      }
    }
  }

  Future<UserCredential?> login(String username, String password) async {
    try {
      await createUserIfNotExist(username, password);

      return await _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final UserCredential userCredential =
          await _auth.signInWithPopup(googleProvider);
      return userCredential;
    } catch (e) {
      // Handle the error
      return null;
    }
  }

  logout() async {
    await _auth.signOut();
  }
}
