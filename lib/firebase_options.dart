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
    apiKey: 'AIzaSyDSIQZxu9y_a6j5AY1wM7VxYbj8vLc_m_U',
    appId: '1:710494466661:web:79e66cad0b7264be1b8c8c',
    messagingSenderId: '710494466661',
    projectId: 'chatgpt-5de52',
    authDomain: 'chatgpt-5de52.firebaseapp.com',
    storageBucket: 'chatgpt-5de52.appspot.com',
    measurementId: 'G-M7MEYY65BX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQy-i7XAhIeYqcGENly6X6Btr8C-2GzFE',
    appId: '1:710494466661:android:9dba78357edf57fd1b8c8c',
    messagingSenderId: '710494466661',
    projectId: 'chatgpt-5de52',
    storageBucket: 'chatgpt-5de52.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACZYiBCOLwdszTQli_evK_SVO2v-yC96A',
    appId: '1:710494466661:ios:6c6f04d123664bf01b8c8c',
    messagingSenderId: '710494466661',
    projectId: 'chatgpt-5de52',
    storageBucket: 'chatgpt-5de52.appspot.com',
    androidClientId: '710494466661-godg1mf6tm72tddj9dtdhu5n2ri47jda.apps.googleusercontent.com',
    iosClientId: '710494466661-b3bsf92r2rp5dh5aef9v3tk3l5sgbu8t.apps.googleusercontent.com',
    iosBundleId: 'com.example.my',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACZYiBCOLwdszTQli_evK_SVO2v-yC96A',
    appId: '1:710494466661:ios:8fe6e949e01c5fb11b8c8c',
    messagingSenderId: '710494466661',
    projectId: 'chatgpt-5de52',
    storageBucket: 'chatgpt-5de52.appspot.com',
    androidClientId: '710494466661-godg1mf6tm72tddj9dtdhu5n2ri47jda.apps.googleusercontent.com',
    iosClientId: '710494466661-mm33uguhsqe6n2bcf8dg4vvlgtrqn8vp.apps.googleusercontent.com',
    iosBundleId: 'com.example.my.RunnerTests',
  );
}
