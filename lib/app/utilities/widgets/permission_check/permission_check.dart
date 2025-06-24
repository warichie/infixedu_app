// Flutter imports:
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// Package imports:
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

// Package imports:

class PermissionCheck {
  Future<void> checkPermissions(BuildContext context) async {
    PermissionStatus? storageStatus;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      storageStatus = android.version.sdkInt < 33
          ? await Permission.storage.request()
          : PermissionStatus.granted;
    }
    if (storageStatus == PermissionStatus.granted) {
      debugPrint("granted");
    }
    if (storageStatus == PermissionStatus.denied) {
      debugPrint("denied");
    }
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  void permissionsDenied() {
     CupertinoAlertDialog(
      title: Text('Permission denied'.tr),
      content: Text('You must grant all permission to use this application'.tr),
    );

    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return SimpleDialog(
    //         title: const Text("Permission denied"),
    //         children: <Widget>[
    //           Container(
    //             padding: const EdgeInsets.only(
    //                 left: 30, right: 30, top: 15, bottom: 15),
    //             child: const Text(
    //               "You must grant all permission to use this application",
    //               style: TextStyle(fontSize: 18, color: Colors.black54),
    //             ),
    //           )
    //         ],
    //       );
    //     });
  }
}
