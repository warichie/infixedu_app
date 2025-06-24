import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class QuoteText extends StatelessWidget {
  final String? repliedText;

  const QuoteText({
    super.key,
    this.repliedText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.customDividerColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${"Replying to".tr} :",
            style: AppTextStyle.blackFontSize12W400,
          ),
          Text(
            repliedText ?? "",
            style: AppTextStyle.fontSize13BlackW400,
          ),
        ],
      ),
    );
  }
}
