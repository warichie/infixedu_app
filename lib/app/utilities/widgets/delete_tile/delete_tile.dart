import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class DeleteTile extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Function()? tapLeftButton;
  final Function()? tapRightButton;
  final Color? color;
  final IconData? leftIcon;
  final Color? leftIconBackgroundColor;
  final IconData? rightIcon;
  final Color? rightIconBackgroundColor;

  const DeleteTile({
    super.key,
    this.title,
    this.subTitle,
    this.tapLeftButton,
    this.tapRightButton,
    this.color,
    this.leftIcon,
    this.rightIcon,
    this.leftIconBackgroundColor,
    this.rightIconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.parentsCardBorderColor,
          ),
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Get.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? "",
                        style: AppTextStyle.syllabusFontSize16W500,
                      ),
                      5.h.verticalSpacing,
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Text(
                          subTitle ?? "",
                          style: AppTextStyle.fontSize12GreyW400,
                        ),
                      ),
                    ],
                  ),
                ),
                10.w.horizontalSpacing,
                Row(
                  children: [
                    leftIcon == null
                        ? const SizedBox()
                        : InkWell(
                            onTap: tapLeftButton,
                            child: Container(
                              height: Get.height * 0.05,
                              width: Get.width * 0.08,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: leftIconBackgroundColor),
                              child: Center(
                                child: Icon(leftIcon,
                                    color: Colors.white, size: 16.h),
                              ),
                            ),
                          ),
                    8.w.horizontalSpacing,
                    rightIcon == null
                        ? const SizedBox()
                        : InkWell(
                            onTap: tapRightButton,
                            child: Container(
                              height: Get.height * 0.05,
                              width: Get.width * 0.08,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: rightIconBackgroundColor,
                              ),
                              child: Center(
                                child: Icon(
                                  rightIcon,
                                  color: Colors.white,
                                  size: 16.h,
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
