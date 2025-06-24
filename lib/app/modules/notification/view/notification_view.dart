import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/notification/view/widget/notification_list_tile.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import '../../../../domain/core/model/notification/notification_model.dart';
import '../../../data/constants/app_text.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/button/primary_button.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalRxVariableController globalRxVariableController = Get.find();
    return Obx(
      () => InfixEduScaffold(
        title: 'Notification'.tr,
        leadingIcon: const SizedBox(),
        body: CustomBackground(
            customWidget: RefreshIndicator(
          onRefresh: () async {
            controller.unReadNotificationList.clear();
            controller.fetchNotifications();
          },
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${"You have".tr} ${globalRxVariableController.notificationCount} ${"New notification".tr}",
                      style: AppTextStyle.notificationText,
                    ),
                    controller.unReadNotificationList.isNotEmpty
                        ? controller.loadingController.isLoading
                            ? const CircularProgressIndicator()
                            : SecondaryButton(
                                onTap: () {
                                  controller.readAllNotifications();
                                },
                                title: AppText.notificationMarkAsRaed.tr,
                                width: 110.w,
                              )
                        : const SizedBox(),
                  ],
                ),
              ),
              controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ))
                  : controller.unReadNotificationList.isEmpty
                      ? const NoDataAvailableWidget()
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.unReadNotificationList.length,
                            itemBuilder: (context, index) {
                              UnreadNotifications? notificationsItem =
                                  controller.unReadNotificationList[index];

                              return NotificationListTile(
                                message: notificationsItem?.message ?? '',
                                // notificationDate: formatTimeAgo(
                                //   DateTime.tryParse(
                                //       notificationsItem?.createdAt ?? '')??DateTime.now().toLocal(),
                                // ),
                                notificationDate: (DateTime.tryParse(
                                            notificationsItem?.createdAt ??
                                                "") ??
                                        DateTime.now())
                                    .yyyy_mm_dd,
                                userPhoto: notificationsItem?.userPhoto,
                              );
                            },
                          ),
                        ),
              30.verticalSpacing
            ],
          ),
        )),
      ),
    );
  }

  String formatTimeAgo(DateTime date) {
    final now = DateTime.now().toLocal();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'a few moments ago'.tr;
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes != 1 ? "minutes ago".tr : "minute ago".tr}';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours != 1 ? "hours ago".tr : "hour ago".tr}';
    } else if (difference.inDays < 30) {
      final days = difference.inDays;
      return '$days ${days != 1 ? "days ago".tr : "day ago".tr}';
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      return '$months ${months != 1 ? "months ago".tr : "month ago".tr}';
    } else {
      final years = difference.inDays ~/ 365;
      return '$years ${years != 1 ? 'years ago'.tr : 'year ago'.tr}';
    }
  }
}
