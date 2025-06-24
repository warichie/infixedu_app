import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';

class BottomSheetTile extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? color;
  final bool hasMultipleData;
  final Widget? listview;
  final double? width;
  final double? height;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;

  const BottomSheetTile({
    super.key,
    this.title,
    this.value,
    this.color,
    this.hasMultipleData = false,
    this.listview,
    this.width,
    this.height,
    this.titleTextStyle,
    this.valueTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return hasMultipleData == true
        ? Container(
            height: Get.height * 0.06,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.homeworkWidgetColor,
              ),
              color: color,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: Get.width * 0.41,
                  child: Text(
                    title ?? "",
                    style: titleTextStyle ?? AppTextStyle.fontSize10GreyW500,
                  ),
                ),
                VerticalDivider(
                  color: AppColors.bottomSheetDividerColor,
                  thickness: 1,
                ),
                Flexible(
                  child: Container(
                    width: Get.width * 0.5,
                    padding: const EdgeInsets.only(top: 10),
                    child: listview,
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: Get.height * 0.04,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.homeworkWidgetColor,
              ),
              color: color,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: width ?? Get.width * 0.41,
                  child: Text(
                    title ?? "",
                    style: titleTextStyle ?? AppTextStyle.fontSize10GreyW500,
                  ),
                ),
                VerticalDivider(
                  color: AppColors.bottomSheetDividerColor,
                  thickness: 1,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Text(
                      value ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: valueTextStyle ?? AppTextStyle.blackFontSize10W400,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
