import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(Get.context!).showSnackBar( SnackBar(content: Text('Text copied to clipboard'.tr)));
}
