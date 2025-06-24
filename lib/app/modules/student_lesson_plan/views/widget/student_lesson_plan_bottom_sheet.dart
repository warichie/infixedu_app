import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';

class StudentLessonPlanBottomSheet extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? color;
  final bool hasMultipleData;

  const StudentLessonPlanBottomSheet({
    super.key,
    this.title,
    this.value,
    this.color,
    this.hasMultipleData = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.homeworkWidgetColor,
        ),
        color: color,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: Get.width * 0.3,
            child: Text(
              title ?? "",
              style: AppTextStyle.fontSize12lightViolateW400,
            ),
          ),
          SizedBox(
            height: Get.height * 0.03,
            child: VerticalDivider(
              color: AppColors.bottomSheetDividerColor,
              thickness: 1,
            ),
          ),

              SizedBox(
                  width: Get.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      value ?? "",
                      style: AppTextStyle.blackFontSize12W400,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
