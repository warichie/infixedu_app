import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class CustomBrowseIcon extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const CustomBrowseIcon({
    super.key,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7.0),
      child: Container(
        width: width?.w ?? 60.w,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? AppColors.primaryColor,
        ),
        child: Center(
          child: Text(
            "Browse".tr,
            style: AppTextStyle.textStyle12WhiteW400,
          ),
        ),
      ),
    );
  }
}
