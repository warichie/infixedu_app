import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';

class ColumnTile extends StatelessWidget {
  final String? title;
  final String? value;
  final double? width;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;

  const ColumnTile({
    super.key,
    this.title,
    this.value,
    this.width,
    this.titleTextStyle,
    this.valueTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width * 0.19,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title ?? "",
            style: titleTextStyle ?? AppTextStyle.fontSize11BlackW400,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              value ?? "",
              style:  AppTextStyle.homeworkElements,
              //textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
