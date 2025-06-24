import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class CustomPopupDialogue extends StatelessWidget {
  final String? title;
  final String subTitle;
  final String noText;
  final String yesText;
  final bool isLoading;
  final Function()? onYesTap;

  const CustomPopupDialogue({
    this.onYesTap,
    super.key,
    this.title,
    this.isLoading = false,
    required this.subTitle,
    required this.noText,
    required this.yesText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? '', style: AppTextStyle.fontSize14BlackW500),
      content: Text(
        subTitle,
        style: AppTextStyle.fontSize12GreyW400,
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            noText.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp),
          ),
        ),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              )
            : TextButton(
                onPressed: onYesTap,
                child: Text(
                  yesText.toUpperCase(),
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp),
                ),
              ),
      ],
    );
  }
}
