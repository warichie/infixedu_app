import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/modules/home/controllers/home_controller.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text.dart';
import '../common_widgets/alert_dialog.dart';

class CustomAppBar extends GetView<HomeController> {
  final Widget? leadingIcon;
  final String? title;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final bool centerTitle;

  const CustomAppBar({
    this.centerTitle = false,
    super.key,
    this.leadingIcon,
    this.title,
    this.actions,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: TargetPlatform.android == defaultTargetPlatform ? 42.0 : 52.0,
          bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                5.w.horizontalSpacing,
                leadingIcon ??
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        color: Colors.transparent,
                        margin: ScreenUtil().deviceType(Get.context!) ==
                                DeviceType.tablet
                            ? EdgeInsets.only(right: 5.w)
                            : null,
                        height: 40,
                        width: 40,
                        child: Platform.isAndroid
                            ? Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 17.w,
                              )
                            : Icon(Icons.arrow_back_ios_new_outlined,
                                color: Colors.white, size: 17.w),
                      ),
                    ),
                5.w.horizontalSpacing,
                Expanded(
                  child: titleWidget ??
                      Text(
                        title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.appBarTitleTextStyle,
                      ),
                ),
              ],
            ),
          ),
          Row(
            children: actions ??
                [
                  InkWell(
                    onTap: () {
                      Get.dialog(
                        CustomPopupDialogue(
                          onYesTap: () {
                            if (!Get.isRegistered<HomeController>()) {
                              Get.put(HomeController);
                            }
                            controller.logout();
                          },
                          title: 'Confirmation'.tr,
                          subTitle:
                              "${"Are you sure".tr}\n${"you want to logout".tr}?",
                          noText: 'Cancel'.tr,
                          yesText: 'Logout'.tr,
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: Icon(
                        Icons.logout_outlined,
                        size: 20.w,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
          ),
        ],
      ),
    );
  }
}
