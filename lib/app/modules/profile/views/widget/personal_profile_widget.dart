import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_colors.dart';

class ProfilePersonalWidget extends StatelessWidget {
  const ProfilePersonalWidget({super.key, this.value, this.icon, this.title});
  final String? value;
  final IconData? icon;
  // final String? icon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            7.h.verticalSpacing,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image.asset(icon ?? "", height: 15, width: 15, color: AppColors.syllabusTextColorBlack,),
                Icon(
                  icon,
                  size: 16.h,
                  color: Colors.black,
                ),
                10.w.horizontalSpacing,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title ?? "",
                      style: AppTextStyle.fontSize10GreyW400,
                    ),
                    0.verticalSpacing,
                    Text(
                      value ?? "",
                      style: AppTextStyle.fontSize10GreyW500,
                    ),
                  ],
                ),
              ],
            ),
            5.h.verticalSpacing,
            CustomDivider(
              width: Get.width,
              color: AppColors.profileDividerColor,
            )
          ],
        ),
      ],
    );
  }
}
