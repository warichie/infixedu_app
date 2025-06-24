import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/widgets/set_attendance_tile/set_attendance_tile.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../../../utilities/widgets/common_widgets/primary_button.dart';
import '../controllers/admin_subject_attendance_search_list_controller.dart';

class AdminSubjectAttendanceSearchListView
    extends GetView<AdminSubjectAttendanceSearchListController> {
  const AdminSubjectAttendanceSearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Set Subject Attendance".tr,
        body: CustomBackground(
          customWidget: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width * 0.50,
                      child: Text(controller.submittedMessage.value,
                          style: TextStyle(
                              fontSize: 10.sp, fontWeight: FontWeight.w400)),
                    ),
                    Obx(
                      () => controller.holidayLoader.value
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : InkWell(
                              onTap: () {
                                controller.markUnMarkHoliday(
                                  purpose: controller.markHoliday.value
                                      ? 'mark'
                                      : 'unmark',
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.primaryColor,
                                ),
                                child: Text(
                                  controller.markHoliday.value
                                      ? "Unmarked Holiday".tr
                                      : "Mark Holiday".tr,
                                  style: AppTextStyle.textStyle12WhiteW400,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                10.h.verticalSpacing,
                controller.isLoading.value
                    ? Expanded(
                        child: Center(
                          child: Platform.isAndroid
                              ? const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : const CupertinoActivityIndicator(
                                  color: AppColors.primaryColor,
                                  radius: 24,
                                ),
                        ),
                      )
                    : controller.adminStudentSubSearchList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount:
                                  controller.adminStudentSubSearchList.length,
                              itemBuilder: (context, index) {
                                var data =
                                    controller.adminStudentSubSearchList[index];

                                return SetAttendanceTile(
                                  studentName: data.fullName,
                                  section: data.section,
                                  studentClass: data.className,
                                  imageUrl: data.studentPhoto,
                                  onPresentButtonTap: () {
                                    controller.updateAttendanceStatus(
                                      index: index,
                                      attendanceType: 'P',
                                    );
                                  },
                                  onAbsentButtonTap: () {
                                    controller.updateAttendanceStatus(
                                      index: index,
                                      attendanceType: 'A',
                                    );
                                  },
                                  onLateButtonTap: () {
                                    controller.updateAttendanceStatus(
                                      index: index,
                                      attendanceType: 'L',
                                    );
                                  },
                                  onHalfDayButtonTap: () {
                                    controller.updateAttendanceStatus(
                                      index: index,
                                      attendanceType: 'F',
                                    );
                                  },
                                  onAddNoteTap: () {
                                    controller
                                        .noteTextController.text = controller
                                            .adminStudentSubSearchList[index]
                                            .note ??
                                        '';
                                    controller.showAddNoteBottomSheet(
                                        index: index, color: Colors.white);
                                  },
                                  attendanceType: data.attendanceType ?? '',
                                );
                              },
                            ),
                          )
                        : const NoDataAvailableWidget(),
                30.h.verticalSpacing,
                controller.saveLoader.value
                    ? const CircularProgressIndicator()
                    : controller.adminStudentSubSearchList.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: controller.markHoliday.value
                                ? const SizedBox()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      PrimaryButton(
                                        text: "Save".tr,
                                        onTap: () {
                                          if (controller.markHoliday.value ==
                                              false) {
                                            controller
                                                .dataFilteringForApiCall();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                          )
                        : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
