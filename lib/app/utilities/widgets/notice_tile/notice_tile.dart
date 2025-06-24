import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';

class NoticeTile extends StatelessWidget {
  final String? noticeTitle;
  final String? noticeDetails;
  final String? noticeDate;
  final Function()? onTap;
  final Color? cardBackgroundColor;

  const NoticeTile({
    super.key,
    this.noticeTitle,
    this.noticeDetails,
    this.noticeDate,
    this.onTap,
    this.cardBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.w),
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: cardBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noticeTitle ?? "",
                  style: AppTextStyle.fontSize16lightBlackW500,
                ),
                5.h.verticalSpacing,
                Text(
                  noticeDetails ?? "",
                  style: AppTextStyle.blackFontSize12W400,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                10.h.verticalSpacing,
                Row(
                  children: [
                    Container(
                      height: 28.h,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xFFFE3E3E)),
                      child: Center(
                        child: Text(
                          "${"Published".tr}: ${noticeDate ?? AppText.noDataAvailable}",
                          style: AppTextStyle.cardTextStyle14WhiteW500,
                        ),
                      ),
                    ),
                    10.w.horizontalSpacing,
                    Expanded(
                      child: InkWell(
                        onTap: onTap,
                        child: Container(
                          height: 28.h,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.appButtonColor),
                          child: Center(
                            child: Text(
                              "View".tr,
                              style: AppTextStyle.cardTextStyle14WhiteW500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
