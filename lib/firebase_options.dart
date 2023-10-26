// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBb48_j4e_DB8-3-DD2zpMgpwgPWuqUNCw',
    appId: '1:981309715127:web:02c4b7840a3aee90e55332',
    messagingSenderId: '981309715127',
    projectId: 'flutter-pokemap',
    authDomain: 'flutter-pokemap.firebaseapp.com',
    storageBucket: 'flutter-pokemap.appspot.com',
    measurementId: 'G-MFR9B5X6W3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2vXnT7LwGnlT8Zfu6VxyAtN2Sk49__iA',
    appId: '1:981309715127:android:920f37eb1824de09e55332',
    messagingSenderId: '981309715127',
    projectId: 'flutter-pokemap',
    storageBucket: 'flutter-pokemap.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAU7ejlET7tZesVwfBmEmvSJdJf7r1C9B4',
    appId: '1:981309715127:ios:b7a3f9b05be9340ce55332',
    messagingSenderId: '981309715127',
    projectId: 'flutter-pokemap',
    storageBucket: 'flutter-pokemap.appspot.com',
    iosClientId: '981309715127-g62ii5m2p3oobda7it6kfniqp2607c46.apps.googleusercontent.com',
    iosBundleId: 'app.josip.pokemonMap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAU7ejlET7tZesVwfBmEmvSJdJf7r1C9B4',
    appId: '1:981309715127:ios:ff000256a13d8880e55332',
    messagingSenderId: '981309715127',
    projectId: 'flutter-pokemap',
    storageBucket: 'flutter-pokemap.appspot.com',
    iosClientId: '981309715127-n0tk61o1m1r8jcm7a8si8qjd8583ot6e.apps.googleusercontent.com',
    iosBundleId: 'app.josip.pokemonMap.RunnerTests',
  );
}