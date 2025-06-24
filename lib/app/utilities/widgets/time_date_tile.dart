import 'package:flutter/material.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../data/constants/app_text_style.dart';

class TimeAndDateTile extends StatelessWidget {
  final String? title;
  final String? date;
  final String? time;
  final double? width;

  const TimeAndDateTile({
    super.key,
    this.title,
    this.date,
    this.width,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: AppTextStyle.homeworkTitle,
          ),
          8.verticalSpacing,
          Text(
            date ?? "",
            style: AppTextStyle.homeworkTitle,
          ),
          2.verticalSpacing,
          Text(
            time ?? "",
            style: AppTextStyle.homeworkTitle,
          ),
        ],
      ),
    );
  }
}
