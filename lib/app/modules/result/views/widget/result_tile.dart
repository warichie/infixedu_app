import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/modules/result/views/widget/flexible_text.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class ResultTile extends StatelessWidget {
  final String? title;
  final String? subject;
  final int? obtainMarks;
  final int? totalMarks;
  final String? grade;
  final Color? color;

  const ResultTile({
    super.key,
    this.title,
    this.subject,
    this.obtainMarks,
    this.totalMarks,
    this.grade,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 30, bottom: 20),
      decoration: BoxDecoration(color: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
          ),
          10.h.verticalSpacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlexibleText(
                text: "Subject".tr,
              ),
              FlexibleText(
                text: "Marks".tr,
              ),
              FlexibleText(
                text: "Obtain".tr,
              ),
              FlexibleText(
                text: "Grade".tr,
              ),
            ],
          ),
          10.h.verticalSpacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlexibleText(
                text: subject ?? "",
              ),
              FlexibleText(
                text: '${totalMarks ?? ""}',
              ),
              FlexibleText(
                text: '${obtainMarks ?? ""}',
              ),
              FlexibleText(
                text: grade ?? "",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
