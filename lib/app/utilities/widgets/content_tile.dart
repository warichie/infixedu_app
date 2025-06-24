import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/colum_tile/column_tile.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class ContentTile extends StatelessWidget {
  final String? title;
  final String? contentType;
  final String? date;
  final String? availableFor;
  final Function()? onDeleteTap;
  final Function()? onDownloadTap;

  const ContentTile({
    super.key,
    this.title,
    this.contentType,
    this.date,
    this.availableFor,
    this.onDeleteTap,
    this.onDownloadTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 15),
                width: Get.width * 0.64,
                child: Text(
                  title ?? "",
                  style: AppTextStyle.fontSize14BlackW500,
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: onDownloadTap,
                    child: Image.asset(
                      ImagePath.download,
                      //scale: 4,
                      width: 16.w,
                      height: 16.w,
                      color: AppColors.activeExamStatusBlueColor,
                    ),
                  ),
                  10.w.horizontalSpacing,
                  InkWell(
                    onTap: onDeleteTap,
                    child: Image.asset(
                      ImagePath.delete,
                      width: 16.w,
                      height: 16.w,
                      color: AppColors.activeStatusRedColor,
                    ),
                  ),
                  10.horizontalSpacing,
                ],
              ),
            ],
          ),
          10.verticalSpacing,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColumnTile(
                title: "Type".tr,
                value: contentType,
              ),
              ColumnTile(
                title: "Date".tr,
                value: date,
              ),
              ColumnTile(
                title: "Available For".tr,
                value: availableFor,
              ),
            ],
          ),
          10.verticalSpacing,
          CustomDivider(
            width: Get.width,
            color: AppColors.customDividerColor,
          )
        ],
      ),
    );
  }
}
