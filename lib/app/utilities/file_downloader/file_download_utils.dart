import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import '../../../config/app_config.dart';
import '../message/snack_bars.dart';

class FileDownloadUtils {
  ReceivePort _port = ReceivePort();

  FileDownloadUtils() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );

    _port.listen((dynamic data) async {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        debugPrint('Download completed for task ID: $id');
      } else {
        debugPrint('Download in progress: $progress%');
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future<void> downloadFiles({
    required String url,
    required String title,
  }) async {
    debugPrint('Download Url ::: $url');

    String directoryLocation = await _getDirectoryPath();
    if (directoryLocation.isEmpty) {
      showBasicSuccessSnackBar(message: "Failed to get storage directory".tr);
      return;
    }

    if (!(await _handlePermission())) return;

    try {
      final taskId = await FlutterDownloader.enqueue(
        headers: {HttpHeaders.acceptEncodingHeader: "*"},
        saveInPublicStorage: true,
        url: url,
        savedDir: directoryLocation,
        fileName: '$title${AppConfig.getExtension(url)}',
        showNotification: true,
        openFileFromNotification: true,
      );

      if (taskId != null) {
        showBasicSuccessSnackBar(message: "Download Started".tr);
      }
    } catch (e, t) {
      Get.snackbar('${"Error".tr}!', 'No file found on server'.tr,
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          barBlur: 0.5);
      debugPrint(e.toString());
      debugPrint(t.toString());
    }
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final DownloadTaskStatus taskStatus = DownloadTaskStatus.values[status];

    debugPrint(
        'Callback received: id = $id, status = $status, progress = $progress');

    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');

    if (send == null) {
      debugPrint('SendPort is null!');
    } else {
      send.send([id, taskStatus, progress]);
    }
  }

  Future<bool> _handlePermission() async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      int sdkVersion = await _getAndroidVersion();
      if (sdkVersion >= 29) {
        return true;
      } else {
        if (await Permission.storage.isPermanentlyDenied) {
          openAppSettings();
          return false;
        } else {
          status = await Permission.storage.request();
        }
      }
    } else {
      status = await Permission.storage.request();
    }

    if (!status.isGranted) {
      showBasicSuccessSnackBar(
          message: "Storage permission is required to download files".tr);
      return false;
    }

    return true;
  }

  Future<String> _getDirectoryPath() async {
    if (Platform.isAndroid) {
      int sdkVersion = await _getAndroidVersion();

      if (sdkVersion >= 29) {
        final externalDir = await getExternalStorageDirectory();
        return externalDir?.path ?? '';
      } else {
        return "/sdcard/Download/";
      }
    } else if (Platform.isIOS) {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    } else {
      return (await getApplicationSupportDirectory()).path;
    }
  }

  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }
}

Future<int> _getAndroidVersion() async {
  final deviceInfo = DeviceInfoPlugin();
  try {
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  } catch (e) {
    debugPrint('Failed to get Android version: $e');
    return 0;
  }
}
