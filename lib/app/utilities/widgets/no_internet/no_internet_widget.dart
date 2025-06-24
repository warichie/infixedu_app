import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NoInternetConnection extends StatelessWidget {
  final String? lottieFilePath;
  final String? message;
  final double? height;
  final Color? backgroundColor;

  const NoInternetConnection(
      {super.key,
      this.lottieFilePath,
      this.message,
      this.height,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height ?? Get.height,
        color: backgroundColor ?? Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(lottieFilePath ?? ImagePath.noInternetConnection),
            Text(message ?? AppText.connectInternetMessage.tr)
          ],
        ),
      ),
    );
  }
}
