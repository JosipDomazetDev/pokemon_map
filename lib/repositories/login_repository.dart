import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
      // Had to add SHA1 fingerprint to firebase android app (in the firebase console)
      // https://stackoverflow.com/questions/54557479/flutter-and-google-sign-in-plugin-platformexceptionsign-in-failed-com-google?page=1&tab=trending#tab-top
      await _googleSignIn.signOut();
      final googleSignInAccount = await _googleSignIn.signIn();

      final googleAuth = await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }

  logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
