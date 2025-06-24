import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../button/primary_button.dart';

class ContentTile extends StatelessWidget {
  final String? dueDate;
  final String? title;
  final String? details;
  final String? description;
  final Function()? onTap;
  final Color? cardBackgroundColor;

  const ContentTile(
      {super.key,
      this.dueDate,
      this.title,
      this.details,
      this.onTap,
      this.cardBackgroundColor,
      this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0.w),
          border: Border.all(width: 1, color: const Color(0xFFEAE7F0)),
          color: cardBackgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: AppTextStyle.fontSize16lightBlackW500,
              ),
              5.verticalSpacing,
              Text(
                details ?? "",
                style: TextStyle(
                  color: AppColors.syllabusTextColor635976,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (description != null && description != '') 5.verticalSpacing,
              if (description != null && description != '')
                Text(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  description ?? "",
                  style: TextStyle(
                    color: AppColors.syllabusTextColor635976,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              10.verticalSpacing,
              Row(
                children: [
                  Container(
                    height: 28.h,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color(0xFFFE3E3E)),
                    child: Center(
                      child: Text(
                        "${"Due".tr}  - $dueDate",
                        style: AppTextStyle.textStyle12WhiteW500,
                      ),
                    ),
                  ),
                  5.w.horizontalSpacing,
                  Expanded(
                    child: SecondaryButton(
                      height: 28,
                      title: "Download".tr.capitalizeFirst,
                      onTap: onTap,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
