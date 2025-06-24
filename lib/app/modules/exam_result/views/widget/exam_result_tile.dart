import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/colum_tile/column_tile.dart';
import '../../../../utilities/widgets/time_date_tile.dart';

class ExamResultTile extends StatelessWidget {
  final String? subject;
  final String? title;
  final String? startingTime;
  final String? endingTime;
  final String? result;
  final Color? color;
  final Color? activeStatusColor;
  final String? startDate;
  final String? endDate;

  const ExamResultTile({
    super.key,
    this.color,
    this.subject,
    this.startingTime,
    this.endingTime,
    this.result,
    this.activeStatusColor,
    this.title,
    this.startDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: AppTextStyle.fontSize14lightBlackW400,
          ),
          10.h.verticalSpacing,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColumnTile(
                title: "Title".tr,
                value: title,
                titleTextStyle: AppTextStyle.homeworkTitle,
                valueTextStyle: AppTextStyle.homeworkTitle,
              ),
              TimeAndDateTile(
                title: "Start".tr,
                date: startDate ?? "",
                time: "(${startingTime ?? ''})",
              ),
              TimeAndDateTile(
                title: "End".tr,
                date: endDate ?? "",
                time: "(${endingTime ?? ''})",
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status".tr,
                    style: AppTextStyle.notificationText,
                  ),
                  5.verticalSpacing,
                  Container(
                    width: 60.w,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: activeStatusColor ??
                            AppColors.homeworkStatusRedColor),
                    child: Center(
                      child: Text(
                        result?.tr ?? "",
                        style: AppTextStyle.textStyle10WhiteW400,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
