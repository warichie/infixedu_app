import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

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
    apiKey: 'AIzaSyBnHvTjM0ikbDaiUaEsFu48oTeIT9wnAFs',
    appId: '1:29155114472:android:e8c0c97f5b786d7976b85d',
    messagingSenderId: '29155114472',
    projectId: 'infix-edu-v2',
    storageBucket: 'infix-edu-v2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8CdZTukLbvVtoyHlwZzLe9f01EK_9E0Y',
    appId: '1:29155114472:ios:6e0a1bfc9f017fc376b85d',
    messagingSenderId: '29155114472',
    projectId: 'infix-edu-v2',
    storageBucket: 'infix-edu-v2.firebasestorage.app',
    iosBundleId: 'com.infixedu.school',
  );

}