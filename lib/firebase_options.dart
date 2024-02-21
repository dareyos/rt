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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAXyJ6tQNAxvFM_WQ-YSvbj7zjQN-8hL8U',
    appId: '1:859186581873:web:e54d1b6a893163142c26d0',
    messagingSenderId: '859186581873',
    projectId: 'todo-6046d',
    authDomain: 'todo-6046d.firebaseapp.com',
    storageBucket: 'todo-6046d.appspot.com',
    measurementId: 'G-SSLVGGYV1F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJbtDVsbXsmQi_znrQy6GziYPyVEVCcnQ',
    appId: '1:859186581873:android:eed73f7beef246c32c26d0',
    messagingSenderId: '859186581873',
    projectId: 'todo-6046d',
    storageBucket: 'todo-6046d.appspot.com',
  );
}
