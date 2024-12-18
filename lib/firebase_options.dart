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
    apiKey: 'AIzaSyAnmmxSVHAtKO4VAtLgIYsh-LgrWNcnSdw',
    appId: '1:299298414837:web:f99d75edac98f985fa65bc',
    messagingSenderId: '299298414837',
    projectId: 'ajudarp-a0b39',
    authDomain: 'ajudarp-a0b39.firebaseapp.com',
    storageBucket: 'ajudarp-a0b39.appspot.com',
    measurementId: 'G-Q0RWYMCE60',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBkdODAJVKwEo3wTBEoTon8aXjwctp5iY',
    appId: '1:299298414837:android:8d6b3b5769f1cd7bfa65bc',
    messagingSenderId: '299298414837',
    projectId: 'ajudarp-a0b39',
    storageBucket: 'ajudarp-a0b39.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcoe_-ZTp-qQOAI6GgfcnLuKETIIBfh4k',
    appId: '1:299298414837:ios:786d7983e0f247bcfa65bc',
    messagingSenderId: '299298414837',
    projectId: 'ajudarp-a0b39',
    storageBucket: 'ajudarp-a0b39.appspot.com',
    iosBundleId: 'com.example.testeAplicacao',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcoe_-ZTp-qQOAI6GgfcnLuKETIIBfh4k',
    appId: '1:299298414837:ios:786d7983e0f247bcfa65bc',
    messagingSenderId: '299298414837',
    projectId: 'ajudarp-a0b39',
    storageBucket: 'ajudarp-a0b39.appspot.com',
    iosBundleId: 'com.example.testeAplicacao',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAnmmxSVHAtKO4VAtLgIYsh-LgrWNcnSdw',
    appId: '1:299298414837:web:57c52ce0603746fafa65bc',
    messagingSenderId: '299298414837',
    projectId: 'ajudarp-a0b39',
    authDomain: 'ajudarp-a0b39.firebaseapp.com',
    storageBucket: 'ajudarp-a0b39.appspot.com',
    measurementId: 'G-PJQSE07QQH',
  );
}
