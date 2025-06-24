import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import '../../../../data/constants/app_colors.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class CustomTabBarItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final TextStyle? textStyle;
  final Function() onTap;

  const CustomTabBarItem({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              title,
              style: textStyle ??
                  TextStyle(
                      color: AppColors.profileCardBackgroundColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700),
            ),
            3.h.verticalSpacing,
            isActive
                ? CustomDivider(
                    width: 50.w,
                    color: AppColors.profileIndicatorColor,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
