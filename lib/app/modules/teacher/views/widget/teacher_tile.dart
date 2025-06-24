import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class TeacherTile extends StatelessWidget {
  final String? teachersName;
  final String? subjectName;
  final String? teachersEmail;
  final String? teachersPhoneNo;
  final Color? tileBackgroundColor;

  const TeacherTile({
    super.key,
    this.teachersName,
    this.subjectName,
    this.teachersEmail,
    this.teachersPhoneNo,
    this.tileBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0.w),
            color: tileBackgroundColor),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  ImagePath.teacher,
                  height: 13.w,
                  width: 13.w,
                ),
                10.w.horizontalSpacing,
                Text(
                  teachersName ?? AppText.noDataAvailable.tr,
                  style: AppTextStyle.teacherColor,
                )
              ],
            ),
            15.verticalSpacing,
            Row(
              children: [
                Icon(Icons.chrome_reader_mode_outlined, size: 12.w),
                10.w.horizontalSpacing,
                Text(
                  subjectName ?? AppText.noDataAvailable.tr,
                  style: AppTextStyle.fontSize13GreyW300,
                )
              ],
            ),
            15.verticalSpacing,
            Row(
              children: [
                Icon(Icons.email_outlined, size: 12.w),
                10.w.horizontalSpacing,
                Text(
                  teachersEmail ?? AppText.noDataAvailable.tr,
                  style: AppTextStyle.fontSize13GreyW300,
                )
              ],
            ),
            15.verticalSpacing,
            Row(
              children: [
                Icon(Icons.phone, size: 12.w),
                10.w.horizontalSpacing,
                Text(
                  teachersPhoneNo ?? AppText.noDataAvailable.tr,
                  style: AppTextStyle.fontSize13GreyW300,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
