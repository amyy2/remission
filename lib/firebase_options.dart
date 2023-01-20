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
    apiKey: 'AIzaSyDOCFr59YzQ_qpmPUtFKrnzSCDHd4hN4V4',
    appId: '1:22494873757:web:942141df3a1792d8402c74',
    messagingSenderId: '22494873757',
    projectId: 'remission-app',
    authDomain: 'remission-app.firebaseapp.com',
    storageBucket: 'remission-app.appspot.com',
    measurementId: 'G-JX9G80285E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCp7-OueAekyDsO_nJFu65j1TvPk9PAnTA',
    appId: '1:22494873757:android:2b6d52aa06ea06c0402c74',
    messagingSenderId: '22494873757',
    projectId: 'remission-app',
    storageBucket: 'remission-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCeyyzAUgNC-W4oD-EGdSDD8CGiUJXTH10',
    appId: '1:22494873757:ios:1b1266b2e5813af2402c74',
    messagingSenderId: '22494873757',
    projectId: 'remission-app',
    storageBucket: 'remission-app.appspot.com',
    iosClientId: '22494873757-jg8ln18m72s347rnat7qddbsm4n2mahf.apps.googleusercontent.com',
    iosBundleId: 'com.example.remission',
  );
}
