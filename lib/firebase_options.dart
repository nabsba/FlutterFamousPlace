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
    apiKey: 'AIzaSyBWtZKi53ivwGS6g-4E7OkkEcKzUMmBSjE',
    appId: '1:56544763641:web:84ecb2c4ca0739a5c08c28',
    messagingSenderId: '56544763641',
    projectId: 'famousplacessba',
    authDomain: 'famousplacessba.firebaseapp.com',
    storageBucket: 'famousplacessba.firebasestorage.app',
    measurementId: 'G-KYD1E7YT71',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA9DpQ5BBq2SoickTCnDyY8YFdIQWz9Y4o',
    appId: '1:56544763641:android:a30619731e508ebcc08c28',
    messagingSenderId: '56544763641',
    projectId: 'famousplacessba',
    storageBucket: 'famousplacessba.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCI3pZwpvne3lZqKpncrCVivO6Wf2zhtmE',
    appId: '1:56544763641:ios:5a66d112efd90e02c08c28',
    messagingSenderId: '56544763641',
    projectId: 'famousplacessba',
    storageBucket: 'famousplacessba.firebasestorage.app',
    iosClientId: '56544763641-pnpcg4ubeujo38l06j3398aimehb3v8d.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFamousPlaces',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCI3pZwpvne3lZqKpncrCVivO6Wf2zhtmE',
    appId: '1:56544763641:ios:5a66d112efd90e02c08c28',
    messagingSenderId: '56544763641',
    projectId: 'famousplacessba',
    storageBucket: 'famousplacessba.firebasestorage.app',
    iosClientId: '56544763641-pnpcg4ubeujo38l06j3398aimehb3v8d.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFamousPlaces',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBWtZKi53ivwGS6g-4E7OkkEcKzUMmBSjE',
    appId: '1:56544763641:web:3c5d7406ffaac43bc08c28',
    messagingSenderId: '56544763641',
    projectId: 'famousplacessba',
    authDomain: 'famousplacessba.firebaseapp.com',
    storageBucket: 'famousplacessba.firebasestorage.app',
    measurementId: 'G-XWY7VZ9CSZ',
  );
}
