import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

/// Requests & displays the current user permissions for this device.
class NotificationPermission{

  static void requestPermissions() async {

    await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

  }

  static void checkPermissions() async {

    if(!await Permission.notification.isGranted){
      requestPermissions();
    }
  }
}
