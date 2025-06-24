import 'package:flutter/material.dart';
import 'package:infixedu/app/modules/student_class/views/widget/class_tile.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/config/global_variable/app_settings_controller.dart';
import 'package:get/get.dart';
import '../controllers/student_class_controller.dart';

class StudentClassView extends GetView<StudentClassController> {
  const StudentClassView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<StudentClassController>()) {
      Get.put(StudentClassController());
    }

    return Obx(
      () => InfixEduScaffold(
        title: "Class".tr,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              CustomBackground(
                customWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpacing,
                    Get.find<AppSettingsController>()
                                    .systemSettings
                                    .value
                                    .data
                                    ?.systemSettings
                                    ?.jitsi ==
                                0 &&
                            Get.find<AppSettingsController>()
                                    .systemSettings
                                    .value
                                    .data
                                    ?.systemSettings
                                    ?.zoom ==
                                0 &&
                            Get.find<AppSettingsController>()
                                    .systemSettings
                                    .value
                                    .data
                                    ?.systemSettings
                                    ?.gmeet ==
                                0 &&
                            Get.find<AppSettingsController>()
                                    .systemSettings
                                    .value
                                    .data
                                    ?.systemSettings
                                    ?.bBB ==
                                0
                        ? const Center(child: NoDataAvailableWidget())
                        : const SizedBox(),

                    /// Jitsi
                    Get.find<AppSettingsController>()
                                .systemSettings
                                .value
                                .data
                                ?.systemSettings
                                ?.jitsi ==
                            0
                        ? const SizedBox()
                        : ClassTile(
                            onlineClassTitle: "Jitsi".tr,
                            onlineClassSubTitle: "List of Virtual Class".tr,
                            onlineClassMeeting: "List of Virtual meeting".tr,
                            onTap: () {
                              controller.isJitsiTapped.value =
                                  !controller.isJitsiTapped.value;
                              // Get.to(() => const LaunchWebView(launchUrl: 'https://pub.dev/packages/flutter_inappwebview/changelog', title: 'Title',));
                            },
                            isParent: controller.globalRxVariableController
                                        .roleId.value ==
                                    3
                                ? true
                                : false,
                            isStudent: controller.globalRxVariableController
                                        .roleId.value ==
                                    2
                                ? true
                                : false,
                            isTapped: controller.isJitsiTapped.value,
                            onSubTitleTap: () {
                              Get.toNamed(Routes.VIRTUAL_CLASS_LIST,
                                  arguments: {
                                    "online_class": "jitsi",
                                  });
                            },
                            onMeetingTap: () {
                              if (controller.globalRxVariableController.roleId
                                      .value !=
                                  2) {
                                Get.toNamed(Routes.VIRTUAL_CLASS_LIST,
                                    arguments: {
                                      "online_class": "jitsi_meeting",
                                    });
                              }
                            },
                          ),
                    10.verticalSpacing,

                    /// Zoom
                    Get.find<AppSettingsController>()
                                .systemSettings
                                .value
                                .data
                                ?.systemSettings
                                ?.zoom ==
                            0
                        ? const SizedBox()
                        : ClassTile(
                            onlineClassTitle: "Zoom".tr,
                            onlineClassSubTitle: "List of Virtual Class".tr,
                            onlineClassMeeting: "List of Virtual meeting".tr,
                            onTap: () {
                              controller.isZoomTapped.value =
                                  !controller.isZoomTapped.value;
                            },
                            isParent: controller.globalRxVariableController
                                        .roleId.value ==
                                    3
                                ? true
                                : false,
                            isStudent: controller.globalRxVariableController
                                        .roleId.value ==
                                    2
                                ? true
                                : false,
                            isTapped: controller.isZoomTapped.value,
                            onSubTitleTap: () {
                              Get.toNamed(Routes.VIRTUAL_CLASS_LIST,
                                  arguments: {
                                    "online_class": "zoom",
                                  });
                            },
                            onMeetingTap: () {
                              if (controller.globalRxVariableController.roleId
                                      .value !=
                                  2) {
                                Get.toNamed(Routes.VIRTUAL_CLASS_LIST,
                                    arguments: {
                                      "online_class": "zoom_meeting",
                                    });
                              }
                            },
                          ),
                    10.verticalSpacing,

                    /// Google meet
                    Get.find<AppSettingsController>()
                                .systemSettings
                                .value
                                .data
                                ?.systemSettings
                                ?.gmeet ==
                            0
                        ? const SizedBox()
                        : ClassTile(
                            onlineClassTitle: "Google Meet".tr,
                            onlineClassSubTitle: "List of Virtual Class".tr,
                            onlineClassMeeting: "List of Virtual meeting".tr,
                            onTap: () {
                              controller.isGoogleMeetTap.value =
                                  !controller.isGoogleMeetTap.value;
                            },
                            isParent: controller.globalRxVariableController
                                        .roleId.value ==
                                    3
                                ? true
                                : false,
                            isStudent: controller.globalRxVariableController
                                        .roleId.value ==
                                    2
                                ? true
                                : false,
                            isTapped: controller.isGoogleMeetTap.value,
                            onSubTitleTap: () {
                              Get.toNamed(Routes.VIRTUAL_CLASS_LIST,
                                  arguments: {
                                    "online_class": "google_meet_class",
                                  });
                            },
                            onMeetingTap: () {
                              if (controller.globalRxVariableController.roleId
                                      .value !=
                                  2) {
                                Get.toNamed(Routes.VIRTUAL_CLASS_LIST,
                                    arguments: {
                                      "online_class": "google_meet_meeting",
                                    });
                              }
                            },
                          ),
                    10.verticalSpacing,

                    /// Big Blue Button
                    Get.find<AppSettingsController>()
                                .systemSettings
                                .value
                                .data
                                ?.systemSettings
                                ?.bBB ==
                            0
                        ? const SizedBox()
                        : ClassTile(
                            onlineClassTitle: "Big Blue Button".tr,
                            onlineClassSubTitle: "List of Virtual Class".tr,
                            onlineClassMeeting: "List of Virtual meeting".tr,
                            onTap: () {
                              controller.isBigBlueButtonTap.value =
                                  !controller.isBigBlueButtonTap.value;
                            },
                            isParent: controller.globalRxVariableController
                                        .roleId.value ==
                                    3
                                ? true
                                : false,
                            isStudent: controller.globalRxVariableController
                                        .roleId.value ==
                                    2
                                ? true
                                : false,
                            isTapped: controller.isBigBlueButtonTap.value,
                            onSubTitleTap: () {
                              Get.toNamed(Routes.VIRTUAL_CLASS_LIST,
                                  arguments: {
                                    "online_class": "big_blue_button",
                                  });
                            },
                            onMeetingTap: () {
                              if (controller.globalRxVariableController.roleId
                                      .value !=
                                  2) {
                                Get.toNamed(Routes.VIRTUAL_CLASS_LIST,
                                    arguments: {
                                      "online_class": "big_blue_button_meeting",
                                    });
                              }
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
