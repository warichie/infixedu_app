import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class RoutineCard extends StatelessWidget {
  final String? subject;
  final String? startingTime;
  final String? endingTime;
  final String? roomNumber;
  final String? buildingName;
  final String? instructorName;
  final bool isLunchBreak;

  const RoutineCard({
    super.key,
    this.subject,
    this.startingTime,
    this.endingTime,
    this.roomNumber,
    this.buildingName,
    this.isLunchBreak = false,
    this.instructorName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: AppColors.parentsCardBorderColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.verticalSpacing,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subject ?? "",
                            style: AppTextStyle.fontSize14VioletW600,
                          ),
                          10.verticalSpacing,
                          Text(
                            "$startingTime - $endingTime",
                            style: AppTextStyle.fontSize12GreyW400,
                          ),
                        ],
                      ),
                    ),
                    isLunchBreak
                        ? const SizedBox()
                        : Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.parentsCardBorderColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${"Room".tr} - ${roomNumber ?? ''}",
                                  style: AppTextStyle.fontSize12GreyW400,
                                ),
                                5.verticalSpacing,
                                Text(
                                  buildingName ?? "",
                                  style:
                                      AppTextStyle.fontSize12lightViolateW400,
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
            10.verticalSpacing,
            isLunchBreak
                ? const SizedBox()
                : CustomDivider(
                    width: Get.width,
                  ),
            10.verticalSpacing,
            isLunchBreak
                ? const SizedBox()
                : Text(
                    instructorName ?? "",
                    style: AppTextStyle.fontSize14lightBlackW400,
                  ),
          ],
        ),
      ),
    );
  }
}
