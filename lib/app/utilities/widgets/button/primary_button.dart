import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class SecondaryButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final Color? borderColor;
  final String? title;
  final TextStyle? textStyle;
  final Function()? onTap;

  const SecondaryButton({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.color,
    this.title,
    this.onTap,
    this.textStyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height?.h ?? 30.h,
        width: width ?? Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 6),
            color: color ?? AppColors.appButtonColor,
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Center(
          child: Text(
            title ?? "Button".tr,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: textStyle ?? AppTextStyle.textStyle12WhiteW500,
          ),
        ),
      ),
    );
  }
}
