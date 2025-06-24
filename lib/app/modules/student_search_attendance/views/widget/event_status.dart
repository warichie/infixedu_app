import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class EventStatus extends StatelessWidget {
  final Color? color;
  final String? title;
  final int? numberOfDays;

  const EventStatus({
    super.key,
    this.color,
    this.title,
    this.numberOfDays,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 20.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: color),
          ),
          10.w.horizontalSpacing,
          Text(
            title ?? "",
            style: AppTextStyle.fontSize14GreyW400,
          ),
          const Spacer(),
          Text(
            "$numberOfDays ${"days".tr}",
            style: AppTextStyle.fontSize14GreyW400,
          ),
        ],
      ),
    );
  }
}
