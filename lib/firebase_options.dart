import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAlk0b-ODirPEJ8V8GFHtm_IUTmZCv4ZGo',
    appId: '1:61814554850:android:61716fc8d0a575bbea9ebb',
    messagingSenderId: '61814554850',
    projectId: 'infix-17653',
    storageBucket: 'infix-17653.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC16Aa4aKcbvUDMc_6m-udjhMxze0p7W7I',
    appId: '1:61814554850:ios:d9dabf4027fb80b662f112',
    messagingSenderId: '61814554850',
    projectId: 'infix-17653',
    iosBundleId: 'com.example.flutterSingleGetxApiV3',
  );
}
