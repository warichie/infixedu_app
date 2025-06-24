import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/firebase_options.dart';
import 'package:infixedu/push_notification/app_push_notification.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'config/language/controller/language_controller.dart';
import 'initializer.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  debugPrint('Handling a background message ${message.messageId}');
}

void firebaseMessagingHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.messageId}');
}

void main() async {
  await Initializer.init();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) =>
      log("OnMessage (foreground notification): ${message.data}"));

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Obx(
        () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData().copyWith(
            dropdownMenuTheme: const DropdownMenuThemeData().copyWith(
              menuStyle: MenuStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  return Colors.white; //your desired selected background color
                }),
              ),
            ),
          ),
          textDirection: Get.find<GlobalRxVariableController>().isRtl.value
              ? TextDirection.rtl
              : TextDirection.ltr,
          locale: language == null ? Get.deviceLocale : Locale(language!),
          translations: LanguageController(),
          fallbackLocale:
              language != null ? Locale(language!) : const Locale('en'),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        ),
      ),
    ),
  );
}
