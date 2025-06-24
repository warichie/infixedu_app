import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../data/constants/app_colors.dart';
import '../../data/constants/app_duration.dart';

void showBasicSuccessSnackBar({
  required String message,
  Widget? icon,
  Function()? onActionTap,
  String buttonText = '',
  double time = 2,
  String? title,
  bool positionTop = false,
}) {
  if (Get.isSnackbarOpen) {
    return;
  }
  Get.rawSnackbar(
    backgroundColor: AppColors.primaryColor,
    padding: EdgeInsets.all(8.w),
    icon: icon ??
         Icon(
          Icons.task_alt_rounded,
          color: Colors.white,
           size: 18.w,
        ),
    animationDuration: AppDuration.snackBarAnimation,
    duration: time.seconds,
    margin: EdgeInsets.all(16.w),
    borderRadius: 10.w,
    snackPosition: positionTop ? SnackPosition.TOP : SnackPosition.TOP,
    mainButton: buttonText.isEmpty
        ? const SizedBox()
        : TextButton(
            onPressed: onActionTap,
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.w,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
    messageText: Text(
      message,
      style:  TextStyle(
        color: Colors.white,
        fontSize: 13.sp
      ),
    ),
    title: title,
  );
}

void showBasicFailedSnackBar({
  required String message,
  Widget? icon,
  Function()? onActionTap,
  String buttonText = '',
  double time = 2.5,
  bool positionTop = true,
}) {
  if (Get.isSnackbarOpen) {
    return;
  }
  Get.rawSnackbar(
    padding: EdgeInsets.all(8.w),
    icon: icon ??
         Icon(
          Icons.priority_high_rounded,
          color: Colors.white,
          size: 18.w,
        ),
    backgroundColor: Colors.deepOrangeAccent,
    animationDuration: 200.milliseconds,
    duration: 2.5.seconds,
    margin: EdgeInsets.all(16.w),
    borderRadius: 10.w,
    snackPosition: positionTop ? SnackPosition.TOP : SnackPosition.TOP,
    mainButton: buttonText.isEmpty
        ? const SizedBox()
        : TextButton(
            onPressed: onActionTap,
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.w,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
    messageText: Text(
      message,
      style: TextStyle(
        color: Colors.white,
        fontSize: 13.sp
      ),
    ),
  );
}

void showBasicProgressDialog({required String message}) {
  Widget dialog = Center(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: AppColors.primaryColor,
                strokeWidth: 1.5,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              message,
            ),
          ],
        ),
      ),
    ),
  );

  Get.dialog(
    dialog,
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 400),
  );
}
