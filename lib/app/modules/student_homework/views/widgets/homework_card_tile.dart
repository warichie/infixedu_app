import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../utilities/widgets/colum_tile/column_tile.dart';

class HomeworkCardTile extends StatelessWidget {
  final String? subject;
  final String? created;
  final String? submission;
  final String? evaluation;
  final String? status;
  final String? marks;
  final Color? statusColor;
  final Color? backgroundColor;
  final Function()? onTap;

  const HomeworkCardTile({
    super.key,
    this.subject,
    this.created,
    this.submission,
    this.evaluation,
    this.status,
    this.marks,
    this.statusColor,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    log("status ::: ${status}");
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.all(20.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "subject" ?? "Subject".tr,
                  style: AppTextStyle.homeworkSubject,
                ),
                InkWell(
                  onTap: onTap,
                  child: Column(
                    children: [
                      Text(
                        "View".tr,
                        style: AppTextStyle.homeworkView,
                      ),
                      CustomDivider(
                        width: 35.w,
                        height: 1,
                        color: AppColors.homeworkViewColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
            20.h.verticalSpacing,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ColumnTile(
                      title: "Created".tr,
                      value: created,
                      width: Get.width * 0.19,
                      titleTextStyle: AppTextStyle.homeworkTitle,
                      valueTextStyle: AppTextStyle.homeworkTitle,
                    ),
                    ColumnTile(
                      title: "Marks".tr,
                      value: marks,
                      width: Get.width * 0.13,
                      titleTextStyle: AppTextStyle.homeworkTitle,
                      valueTextStyle: AppTextStyle.homeworkTitle,
                    ),
                    ColumnTile(
                      title: "Submission".tr,
                      value: submission,
                      width: Get.width * 0.2,
                      titleTextStyle: AppTextStyle.homeworkTitle,
                      valueTextStyle: AppTextStyle.homeworkTitle,
                    ),
                    ColumnTile(
                      title: "Evaluation".tr,
                      value: evaluation,
                      width: Get.width * 0.2,
                      titleTextStyle: AppTextStyle.homeworkTitle,
                      valueTextStyle: AppTextStyle.homeworkTitle,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Status".tr,
                            style: AppTextStyle.homeworkTitle,
                          ),
                          4.h.verticalSpacing,
                          status != null
                              ? Container(
                                  // height: 18.w,
                                  width: 83.w,
                                  padding: EdgeInsets.symmetric(horizontal: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: statusColor,
                                  ),
                                  child: Text(
                                    status?.tr ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: AppTextStyle.textStyle10WhiteW300,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
                10.verticalSpacing,
                // ColumnTile(
                //   title: "Marks",
                //   value: marks,
                //   titleTextStyle: AppTextStyle.homeworkTitle,
                //   valueTextStyle: AppTextStyle.homeworkTitle,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
