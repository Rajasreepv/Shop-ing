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
    apiKey: 'AIzaSyCBZylz0WVsgT9WyPOjQE6vaF2EzeUdzKM',
    appId: '1:247541824670:web:0b94710f75095f348f8f8f',
    messagingSenderId: '247541824670',
    projectId: 'shop-ing-a283d',
    authDomain: 'shop-ing-a283d.firebaseapp.com',
    storageBucket: 'shop-ing-a283d.appspot.com',
    measurementId: 'G-6ZP08HK01Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhqWrYnLTMGXW3RtUhzZvuvpiTiIxFyPg',
    appId: '1:247541824670:android:6fcad7950d6b5ead8f8f8f',
    messagingSenderId: '247541824670',
    projectId: 'shop-ing-a283d',
    storageBucket: 'shop-ing-a283d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuldZMPvolhNW22XfDPq1m3cDoTevqsgs',
    appId: '1:247541824670:ios:40d34f6701f9e8398f8f8f',
    messagingSenderId: '247541824670',
    projectId: 'shop-ing-a283d',
    storageBucket: 'shop-ing-a283d.appspot.com',
    iosBundleId: 'com.example.weatherapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuldZMPvolhNW22XfDPq1m3cDoTevqsgs',
    appId: '1:247541824670:ios:1562c42797fc6d508f8f8f',
    messagingSenderId: '247541824670',
    projectId: 'shop-ing-a283d',
    storageBucket: 'shop-ing-a283d.appspot.com',
    iosBundleId: 'com.example.weatherapp.RunnerTests',
  );
}
