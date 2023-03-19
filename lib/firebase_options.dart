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
    apiKey: 'AIzaSyCwjEcpk6TgFp_AcyM9tqb_r8Jz77iD9YM',
    appId: '1:945016982663:web:f5288a2ec01fc3956afc22',
    messagingSenderId: '945016982663',
    projectId: 'finds-3dd17',
    authDomain: 'finds-3dd17.firebaseapp.com',
    storageBucket: 'finds-3dd17.appspot.com',
    measurementId: 'G-F6DPYQ0JKR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDD1OlS3jKeRWfp8OIrp_z4DDVnzqyYrYc',
    appId: '1:945016982663:android:c7ccab4ce22221b36afc22',
    messagingSenderId: '945016982663',
    projectId: 'finds-3dd17',
    storageBucket: 'finds-3dd17.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCT5DhMnJ1PX6aOcD0v715nASSsgPkYioE',
    appId: '1:945016982663:ios:3e3d3559df7b983d6afc22',
    messagingSenderId: '945016982663',
    projectId: 'finds-3dd17',
    storageBucket: 'finds-3dd17.appspot.com',
    iosClientId: '945016982663-f89p1h23st0rc32unn4c3d6s8p2iiss1.apps.googleusercontent.com',
    iosBundleId: 'com.example.find',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCT5DhMnJ1PX6aOcD0v715nASSsgPkYioE',
    appId: '1:945016982663:ios:3e3d3559df7b983d6afc22',
    messagingSenderId: '945016982663',
    projectId: 'finds-3dd17',
    storageBucket: 'finds-3dd17.appspot.com',
    iosClientId: '945016982663-f89p1h23st0rc32unn4c3d6s8p2iiss1.apps.googleusercontent.com',
    iosBundleId: 'com.example.find',
  );
}