import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../colum_tile/column_tile.dart';

class DormitoryCardTile extends StatelessWidget {
  final String? dormitoryName;
  final String? roomNoName;
  final String? roomType;
  final int? numberOfBed;
  final int? cost;
  final String? activeStatus;
  final Color? color;
  final Color? activeStatusColor;
  final bool isAdminRoomList;

  const DormitoryCardTile({
    super.key,
    this.dormitoryName,
    this.numberOfBed,
    this.cost,
    this.activeStatus,
    this.color,
    this.activeStatusColor,
    this.roomNoName,
    this.isAdminRoomList = false,
    this.roomType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dormitoryName ?? AppText.noDataAvailable,
            style: AppTextStyle.fontSize14lightBlackW400,
          ),
          10.h.verticalSpacing,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColumnTile(
                title: isAdminRoomList ? "Room Name".tr : "Room no".tr,
                value: roomNoName ?? "",
                width: Get.width * 0.22,
                titleTextStyle: AppTextStyle.roomListColumnTitleTextStyle,
                valueTextStyle: AppTextStyle.roomListColumnSubTitleTextStyle,
              ),
              ColumnTile(
                title: "No. of Bed".tr,
                value: "${numberOfBed ?? ""}",
                width: Get.width * 0.22,
                titleTextStyle: AppTextStyle.roomListColumnTitleTextStyle,
                valueTextStyle: AppTextStyle.roomListColumnSubTitleTextStyle,
              ),
              ColumnTile(
                title: "Cost".tr,
                value: "${cost ?? ""}",
                width: Get.width * 0.18,
                titleTextStyle: AppTextStyle.roomListColumnTitleTextStyle,
                valueTextStyle: AppTextStyle.roomListColumnSubTitleTextStyle,
              ),
              isAdminRoomList
                  ? ColumnTile(
                      title: "Room Type".tr,
                      value: roomType ?? "Single".tr,
                      width: Get.width * 0.2,
                      titleTextStyle: AppTextStyle.roomListColumnTitleTextStyle,
                      valueTextStyle:
                          AppTextStyle.roomListColumnSubTitleTextStyle,
                    )
                  : Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Status".tr,
                            style: AppTextStyle.notificationText,
                          ),
                          3.h.verticalSpacing,
                          activeStatus != ''
                              ? Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: activeStatusColor),
                                  child: Center(
                                    child: Text(
                                      activeStatus ??
                                          AppText.noDataAvailable.tr,
                                      style: AppTextStyle.textStyle10WhiteW400,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
            ],
          ),
          10.h.verticalSpacing,
          CustomDivider(
            width: Get.width,
            color: AppColors.customDividerColor,
          )
        ],
      ),
    );
  }
}
