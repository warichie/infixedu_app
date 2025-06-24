import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class CustomTextCard extends StatelessWidget {
  final double? height;
  final double? width;
  final String? title;
  final String? subTitle;

  const CustomTextCard({
    super.key,
    this.height,
    this.width,
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height?.h ?? 48.h,
      width: width ?? Get.width / 2,
      padding: EdgeInsets.only(left: 6.w, top: 7, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$title',
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.white,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '$subTitle',
            style: AppTextStyle.fontSize13WhiteWight700,
          ),
        ],
      ),
    );
  }
}
