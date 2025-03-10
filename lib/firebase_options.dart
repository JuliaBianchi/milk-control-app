// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBN_DfMqbEP01LYe_Q5FYmwSXeaArbZqNQ',
    appId: '1:319670748140:web:6aa77e4fa0a05cce4436c9',
    messagingSenderId: '319670748140',
    projectId: 'milk-control-a',
    authDomain: 'milk-control-a.firebaseapp.com',
    storageBucket: 'milk-control-a.appspot.com',
    measurementId: 'G-TD0Z1D70FP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHcw-2EiaOSy1Zi5ZVH0q6d9XkSLKRdQg',
    appId: '1:319670748140:android:1fbd241478f5b6f14436c9',
    messagingSenderId: '319670748140',
    projectId: 'milk-control-a',
    storageBucket: 'milk-control-a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjCfmfu4Lp4WAxDPavg5cvZBwFpVXpfMM',
    appId: '1:319670748140:ios:f17ee9b56567cddb4436c9',
    messagingSenderId: '319670748140',
    projectId: 'milk-control-a',
    storageBucket: 'milk-control-a.appspot.com',
    iosBundleId: 'com.example.milkcontrolapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjCfmfu4Lp4WAxDPavg5cvZBwFpVXpfMM',
    appId: '1:319670748140:ios:f17ee9b56567cddb4436c9',
    messagingSenderId: '319670748140',
    projectId: 'milk-control-a',
    storageBucket: 'milk-control-a.appspot.com',
    iosBundleId: 'com.example.milkcontrolapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBN_DfMqbEP01LYe_Q5FYmwSXeaArbZqNQ',
    appId: '1:319670748140:web:6a939ccfa731a7714436c9',
    messagingSenderId: '319670748140',
    projectId: 'milk-control-a',
    authDomain: 'milk-control-a.firebaseapp.com',
    storageBucket: 'milk-control-a.appspot.com',
    measurementId: 'G-FHZDC4XSW2',
  );

}