import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class GuardianItemWidget extends StatelessWidget {
  const GuardianItemWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: AppColors.profileValueColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500),
        ),
        5.h.verticalSpacing,
        CustomDivider(
          color: AppColors.profileDividerColor,
          width: Get.width * 0.55,
        ),
      ],
    );
  }
}
