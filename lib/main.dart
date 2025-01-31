import 'dart:developer';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/fees/paymentGateway/khalti/sdk/khalti.dart';
import 'utils/widget/page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// ignore: prefer_typing_uninitialized_variables
var language;
bool langValue = false;

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    setupNotification();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor:
          const Color(0xff280073), //or set color with: Color(0xFF0000FF)
    ));
    HttpOverrides.global = MyHttpOverrides();
    final sharedPref = await SharedPreferences.getInstance();
    language = sharedPref.getString('language');
    debugPrint(language);
    await Khalti.init(
      publicKey: khaltiPublicKey,
      enabledDebugging: true,
    );
  } catch (e, tr) {
    log("Error ------> $e");
    log("Track ------> $tr");
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MainPage();
  }
}

void setupNotification() {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      // '@mipmap/ic_launcher',
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group',
        )
      ],
      debug: true);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print('Handling a background message: ${message.messageId}');
  print('Handling a background message: ${message.data}');

  if (!AwesomeStringUtils.isNullOrEmpty(message.notification?.title,
          considerWhiteSpaceAsEmpty: true) ||
      !AwesomeStringUtils.isNullOrEmpty(message.notification?.body,
          considerWhiteSpaceAsEmpty: true)) {
    print('message also contained a notification: ${message.notification}');

    String? imageUrl;
    imageUrl ??= message.notification?.android?.imageUrl ?? '';

    Map<String, dynamic> notificationAdapter = {
      NOTIFICATION_CHANNEL_KEY: 'basic_channel',
      NOTIFICATION_ID: message.data[NOTIFICATION_CONTENT][NOTIFICATION_ID] ??
          message.messageId ??
          math.Random().nextInt(2147483647),
      NOTIFICATION_TITLE: message.data[NOTIFICATION_CONTENT]
              [NOTIFICATION_TITLE] ??
          message.notification?.title,
      NOTIFICATION_BODY: message.data[NOTIFICATION_CONTENT]
              [NOTIFICATION_BODY] ??
          message.notification?.body,
      NOTIFICATION_LAYOUT:
          AwesomeStringUtils.isNullOrEmpty(imageUrl) ? 'Default' : 'BigPicture',
      NOTIFICATION_BIG_PICTURE: imageUrl
    };

    AwesomeNotifications().createNotificationFromJsonData(notificationAdapter);
  } else {
    AwesomeNotifications().createNotificationFromJsonData(message.data);
  }
}
