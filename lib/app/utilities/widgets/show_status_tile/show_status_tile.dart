import 'package:flutter/material.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../colum_tile/column_tile.dart';

class ShowStatusTile extends StatelessWidget {
  final String? firstTitle;

  final String? secondTitle;
  final String? thirdTitle;
  final String? firstValue;
  final String? secondValue;
  final String? thirdValue;
  final Function()? onStatusTap;
  final String? activeStatus;
  final Color? activeStatusColor;

  const ShowStatusTile({
    super.key,
    this.firstTitle,
    this.secondTitle,
    this.thirdTitle,
    this.firstValue,
    this.activeStatus,
    this.activeStatusColor,
    this.secondValue,
    this.thirdValue,
    this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.verticalSpacing,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ColumnTile(
              title: firstTitle,
              value: firstValue,
            ),
            ColumnTile(
              title: secondTitle,
              value: secondValue,
            ),
            ColumnTile(
              title: thirdTitle,
              value: thirdValue,
            ),
            InkWell(
              onTap: onStatusTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Status".tr,
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  5.verticalSpacing,
                  activeStatus != null
                      ? Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: activeStatusColor),
                          child: Center(
                            child: Text(
                              activeStatus?.tr ?? "",
                              style: AppTextStyle.textStyle10WhiteW400,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
        10.verticalSpacing,
        CustomDivider(
          width: Get.width,
          color: AppColors.customDividerColor,
        ),
      ],
    );
  }
}
