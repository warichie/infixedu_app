import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class SettingsTile extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String? title;
  final double? iconHeight;
  final double? iconWidth;
  final bool isLanguage;
  final String? languageName;
  final Color? backgroundColor;
  final Function()? onTileTap;

  const SettingsTile({
    super.key,
    this.icon,
    this.title,
    this.isLanguage = true,
    this.languageName,
    this.onTileTap,
    this.iconColor,
    this.iconHeight,
    this.iconWidth,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTileTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 30.w,
                    width: 30.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: backgroundColor ?? AppColors.homeTextColor,
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        size: 16.w,
                        color: iconColor ?? Colors.white,
                      ),

                      // Image.asset(
                      //   icon ?? "",
                      //   color: iconColor ?? Colors.white,
                      //   height: iconHeight ?? 20,
                      //   width: iconWidth ?? 20,
                      // ),
                    ),
                  ),
                  10.w.horizontalSpacing,
                  Text(
                    title ?? "",
                    style: AppTextStyle.fontSize14BlackW500,
                  ),
                ],
              ),
              isLanguage
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.homeTextColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8),
                        child: Center(
                          child: Text(
                            languageName ?? "English".tr,
                            style: AppTextStyle.textStyle12WhiteW500,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        8.verticalSpacing,
        CustomDivider(
          width: Get.width,
        )
      ],
    );
  }
}
