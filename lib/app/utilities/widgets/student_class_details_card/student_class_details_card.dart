import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../common_widgets/custom_divider.dart';

class StudentClassDetailsCard extends StatelessWidget {
  final String? subject;
  final String? startingTime;
  final String? endingTime;
  final String? roomNumber;
  final String? buildingName;
  final String? instructorName;
  final bool isBreak;
  final bool hasDetails;
  final Function()? onTap;
  final bool onDetailsButtonTap;
  final Widget? buttonWidget;

  const StudentClassDetailsCard({
    super.key,
    this.subject,
    this.startingTime,
    this.endingTime,
    this.roomNumber,
    this.buildingName,
    this.instructorName,
    this.isBreak = false,
    this.onTap,
    this.hasDetails = false,
    this.onDetailsButtonTap = false,
    this.buttonWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.parentsCardBorderColor,
        ),
        borderRadius: BorderRadius.circular(8.w),
      ),
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: Colors.white,
            border: Border.all(color: AppColors.borderColorEAE7F0, width: 1)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0.w, horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.h.verticalSpacing,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isBreak ? "Lunch Break".tr : subject ?? "",
                              style: AppTextStyle.fontSize14VioletW600,
                            ),
                            10.h.verticalSpacing,
                            Text(
                              "$startingTime - $endingTime",
                              style: AppTextStyle.fontSize12GreyW400,
                            ),
                          ],
                        ),
                      ),
                      isBreak
                          ? const SizedBox()
                          : Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.parentsCardBorderColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${"Room".tr} - ${roomNumber ?? ''}",
                                    style: AppTextStyle.fontSize12GreyW400,
                                  ),
                                  5.h.verticalSpacing,
                                  Text(
                                    buildingName ?? "-",
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
              9.h.verticalSpacing,
              isBreak
                  ? const SizedBox()
                  : CustomDivider(
                      width: Get.width,
                    ),
              5.h.verticalSpacing,
              isBreak
                  ? const SizedBox()
                  : Row(
                      children: [
                        Text(
                          instructorName ?? "",
                          style: AppTextStyle.fontSize14lightBlackW400,
                        ),
                        const Spacer(),
                        hasDetails
                            ? InkWell(
                                onTap: onTap,
                                child: buttonWidget ??
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: AppColors.primaryColor,
                                      ),
                                      child: Text(
                                        "Details".tr,
                                        style:
                                            AppTextStyle.textStyle12WhiteW400,
                                      ),
                                    ),
                              )
                            : const SizedBox()
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
