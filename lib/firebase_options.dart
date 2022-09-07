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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9jnCPF7cF7GLTM3iEDUZS-9htJPWI-gw',
    appId: '1:713480601621:android:3d989f58e414d06d330e1c',
    messagingSenderId: '713480601621',
    projectId: 'killstreak-7038f',
    databaseURL: 'https://killstreak-7038f-default-rtdb.firebaseio.com',
    storageBucket: 'killstreak-7038f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCxROqWhh_Nd4wpqh3CXCzPq6QS5nXQho',
    appId: '1:713480601621:ios:4202ff3596fce66c330e1c',
    messagingSenderId: '713480601621',
    projectId: 'killstreak-7038f',
    databaseURL: 'https://killstreak-7038f-default-rtdb.firebaseio.com',
    storageBucket: 'killstreak-7038f.appspot.com',
    iosClientId: '713480601621-hi9a3413hlp1smh8cknap3i21ubf39ct.apps.googleusercontent.com',
    iosBundleId: 'com.example.killstreak',
  );
}