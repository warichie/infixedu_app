import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/single_chat/views/widget/chat_text_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/common_widgets/custom_divider.dart';

class PopupActionMenu extends StatelessWidget {
  final Function()? onQuoteTap;
  final Function()? onForwardTap;
  final Function()? onDeleteTap;
  final double? positionRight;
  final double? positionLeft;
  final String? text;
  final String? imageUrl;
  final Color? color;
  final TextStyle? textStyle;
  final double? radiusBottomLeft;
  final double? radiusBottomRight;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool isReceiver;

  final bool isDisableForwarding;

  const PopupActionMenu(
      {super.key,
      this.onQuoteTap,
      this.onForwardTap,
      this.onDeleteTap,
      this.positionRight,
      this.positionLeft,
      this.text,
      this.color,
      this.textStyle,
      this.radiusBottomLeft,
      this.radiusBottomRight,
      this.crossAxisAlignment,
      this.imageUrl,
      this.isReceiver = false,
      this.isDisableForwarding = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(
                color: Colors.black12,
              ),
            ),
          ),
          Positioned(
            right: positionRight,
            left: positionLeft,
            top: imageUrl == null ? Get.height * 0.5 : Get.height * 0.2,
            child: Column(
              crossAxisAlignment: crossAxisAlignment!,
              children: [
                SizedBox(
                  width: 300.w,
                  child: ChatTextTile(
                    text: text ?? '',
                    color: color,
                    imageUrl: imageUrl ?? '',
                    textStyle: textStyle,
                    radiusBottomLeft: radiusBottomLeft,
                    radiusBottomRight: radiusBottomRight,
                  ),
                ),
                Container(
                  width: 150.w,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: onQuoteTap,
                        child: Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: Row(
                            children: [
                              Icon(
                                Icons.question_answer_outlined,
                                color: AppColors.primaryColor,
                                size: 20.h,
                              ),
                              10.w.horizontalSpacing,
                              Text(
                                "Quote".tr,
                                style: AppTextStyle.fontSize13BlackW400,
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomDivider(
                        width: Get.width,
                      ),
                      if (isDisableForwarding)
                        InkWell(
                          onTap: onForwardTap,
                          child: Padding(
                            padding: EdgeInsets.all(10.0.w),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.forward_to_inbox,
                                  color: AppColors.primaryColor,
                                  size: 20.h,
                                ),
                                10.h.horizontalSpacing,
                                Text(
                                  "Forward".tr,
                                  style: AppTextStyle.fontSize13BlackW400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      isReceiver
                          ? const SizedBox()
                          : CustomDivider(
                              width: Get.width,
                            ),
                      isReceiver
                          ? const SizedBox()
                          : InkWell(
                              onTap: onDeleteTap,
                              child: Padding(
                                padding: EdgeInsets.all(10.0.w),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 20.h,
                                    ),
                                    10.w.horizontalSpacing,
                                    Text(
                                      "Delete".tr,
                                      style: AppTextStyle.fontSize13BlackW400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
