import 'package:flutter/material.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class SearchDetailsTile extends StatelessWidget {
  final String? subject;
  final String? teacher;
  final String? lectureType;
  final Function()? onTap;

  const SearchDetailsTile({
    super.key,
    this.subject,
    this.teacher,
    this.lectureType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Get.width * 0.25,
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
                  width: Get.width * 0.25,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      teacher ?? "",
                      style: AppTextStyle.fontSize13BlackW400,
                    ),
                  ),
                ),
                5.horizontalSpacing,
                SizedBox(
                  width: Get.width * 0.25,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      lectureType ?? "",
                      style: AppTextStyle.fontSize13BlackW400,
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
      ),
    );
  }
}
