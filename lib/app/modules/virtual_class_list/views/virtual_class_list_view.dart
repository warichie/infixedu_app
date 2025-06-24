import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/virtual_class_list/controllers/virtual_class_list_controller.dart';
import 'package:infixedu/app/modules/virtual_class_list/views/widget/virtual_class_tile.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/clipboard/custom_clipboard.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

class VirtualClassListView extends GetView<VirtualClassListController> {
  const VirtualClassListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: controller.onlineClass.value == 'jitsi' ||
                controller.onlineClass.value == 'zoom' ||
                controller.onlineClass.value == 'google_meet_class' ||
                controller.onlineClass.value == 'big_blue_button'
            ? 'List of Virtual Class'.tr
            : 'List of Virtual meeting'.tr,
        body: CustomBackground(
          customWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.h.verticalSpacing,
              Expanded(
                child: controller.meetingLoader.value
                    ? const SecondaryLoadingWidget()
                    : controller.meetingList.isNotEmpty
                        ? RefreshIndicator(
                            color: AppColors.primaryColor,
                            onRefresh: () async {
                              controller.meetingList.clear();
                              controller.getZoomMeetingList();
                            },
                            child: ListView.builder(
                              itemCount: controller.meetingList.length,
                              itemBuilder: (context, index) {
                                String colorCode = '';
                                if (controller.meetingList[index].currentStatus
                                        ?.toUpperCase() ==
                                    'CLOSED') {
                                  colorCode = '0xFFF95452';
                                } else if (controller
                                        .meetingList[index].currentStatus
                                        ?.toUpperCase() ==
                                    'WAITING') {
                                  colorCode = '0xFFFFBE00';
                                } else {
                                  colorCode = '0xFF3AC172';
                                }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: VirtualClassTile(
                                    topic: controller.meetingList[index].topic,
                                    startingTime:
                                        controller.meetingList[index].startTime,
                                    duration: controller
                                        .meetingList[index].duration
                                        .toString(),
                                    meetingPassword: controller
                                        .meetingList[index].meetingPassword,
                                    activeStatusColor:
                                        Color(int.tryParse(colorCode)!),
                                    activeStatus: controller
                                        .meetingList[index].currentStatus,
                                    date:
                                        controller.meetingList[index].startDate,
                                    onTap: () {
                                      if (controller.meetingList[index]
                                                  .currentStatus
                                                  ?.toUpperCase() ==
                                              'JOIN' ||
                                          controller.meetingList[index]
                                                  .currentStatus
                                                  ?.toUpperCase() ==
                                              'START') {
                                        if (controller.onlineClass.value ==
                                                "big_blue_button" ||
                                            controller.onlineClass.value ==
                                                "big_blue_button_meeting") {
                                          controller.openBBB(
                                              title: controller
                                                  .meetingList[index].topic,
                                              webUrl: controller
                                                  .meetingList[index].joinUrl);
                                        } else if (controller
                                                    .onlineClass.value ==
                                                'zoom' ||
                                            controller.onlineClass.value ==
                                                'zoom_meeting') {
                                          controller.openZoom(
                                            meetingId: controller
                                                    .meetingList[index]
                                                    .meetingId ??
                                                '',
                                            status: controller
                                                    .meetingList[index]
                                                    .currentStatus ??
                                                '',
                                          );
                                        } else if (controller
                                                    .onlineClass.value ==
                                                "jitsi" ||
                                            controller.onlineClass.value ==
                                                "jitsi_meeting") {
                                          controller.openJitsiMeet(
                                              status: controller
                                                      .meetingList[index]
                                                      .currentStatus ??
                                                  '',
                                              meetingID: controller
                                                      .meetingList[index]
                                                      .meetingId ??
                                                  '');
                                          // controller.join(
                                          //   roomId: controller
                                          //       .meetingList[index]
                                          //       .meetingId!,
                                          // );
                                        } else if (controller
                                                    .onlineClass.value ==
                                                'google_meet_class' ||
                                            controller.onlineClass.value ==
                                                'google_meet_meeting') {
                                          controller.openGoogleMeet(
                                              status: controller
                                                      .meetingList[index]
                                                      .currentStatus ??
                                                  "",
                                              url: controller.meetingList[index]
                                                      .joinUrl ??
                                                  "");
                                        }
                                      }
                                    },
                                    onTapForCopy: () {
                                      copyToClipboard(controller
                                          .meetingList[index].meetingPassword!);
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: NoDataAvailableWidget(),
                          ),
              ),
              30.verticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
