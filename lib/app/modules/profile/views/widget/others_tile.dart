import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class OthersTile extends StatelessWidget {
  final String title;
  final String value;

  const OthersTile({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: Get.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.fontSize10GreyW500,
                ),
                8.h.verticalSpacing,
                CustomDivider(
                  width: Get.width,
                  color: AppColors.profileDividerColor,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            width: Get.width * 0.38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: AppTextStyle.fontSize10W500,
                ),
                8.h.verticalSpacing,
                CustomDivider(
                  width: Get.width,
                  color: AppColors.profileDividerColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
