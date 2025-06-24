import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';

class SubjectTile extends StatelessWidget {
  final String? subject;
  final String? teacher;
  final String? lectureType;

  const SubjectTile({
    super.key,
    this.subject,
    this.teacher,
    this.lectureType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    subject ?? "",
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                ),
              ),
              5.horizontalSpacing,
              SizedBox(
                width: Get.width * 0.3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    teacher ?? "",
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                ),
              ),
              5.horizontalSpacing,
              Flexible(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      lectureType ?? "",
                      style: AppTextStyle.fontSize13BlackW400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          10.verticalSpacing,
          CustomDivider(
            width: Get.width,
            color: AppColors.profileDividerColor,
          )
        ],
      ),
    );
  }
}
