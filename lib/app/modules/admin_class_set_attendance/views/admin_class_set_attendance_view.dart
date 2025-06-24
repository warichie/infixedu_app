import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/widgets/set_attendance_tile/set_attendance_tile.dart';

import 'package:get/get.dart';

import '../controllers/admin_class_set_attendance_controller.dart';

class AdminClassSetAttendanceView
    extends GetView<AdminClassSetAttendanceController> {
  const AdminClassSetAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Set Class Attendance".tr,
      body: CustomBackground(
        customWidget: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: controller.attendanceStudentData.students == null ||
                  controller.attendanceStudentData.students!.isEmpty
              ? const NoDataAvailableWidget()
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.50,
                          child: Obx(() => Text(
                                controller.submittedMessage.value,
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w300),
                              )),
                        ),
                        5.h.horizontalSpacing,
                        Obx(
                          () => controller.holidayLoader.value
                              ? const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : InkWell(
                                  onTap: () {
                                    controller.markUnMarkHoliday();
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
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          itemCount:
                              controller.adminClassSetAttendanceList.length,
                          itemBuilder: (context, index) {
                            var data =
                                controller.adminClassSetAttendanceList[index];

                            return SetAttendanceTile(
                              studentName: controller.attendanceStudentData
                                  .students![index].fullName,
                              section:
                                  controller.attendanceStudentData.sectionName,
                              studentClass:
                                  controller.attendanceStudentData.className,
                              imageUrl:
                                  "${controller.adminClassSetAttendanceList[index].studentPhoto}",
                              isImageEmpty: false,
                              onPresentButtonTap: () {
                                controller.updateAttendance(
                                  index: index,
                                  attendanceType: 'P',
                                );
                              },
                              onAbsentButtonTap: () {
                                controller.updateAttendance(
                                  index: index,
                                  attendanceType: 'A',
                                );
                              },
                              onLateButtonTap: () {
                                controller.updateAttendance(
                                  index: index,
                                  attendanceType: 'L',
                                );
                              },
                              onHalfDayButtonTap: () {
                                controller.updateAttendance(
                                  index: index,
                                  attendanceType: 'F',
                                );
                              },
                              onAddNoteTap: () {
                                controller.noteTextController.text = controller
                                        .adminClassSetAttendanceList[index]
                                        .note ??
                                    '';
                                controller.showAddNoteBottomSheet(
                                    index: index, color: Colors.white);
                              },
                              attendanceType: data.attendanceType ?? '',
                            );
                          },
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.saveLoader.value
                          ? const SecondaryLoadingWidget(
                              isBottomNav: true,
                            )
                          : controller.adminClassSetAttendanceList.isNotEmpty
                              ? controller.markHoliday.value
                                  ? const SizedBox()
                                  : Container(
                                      height: Get.height * 0.1,
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      child: PrimaryButton(
                                        text: "Save".tr,
                                        onTap: () {
                                          if (controller.markHoliday.value ==
                                              false) {
                                            controller.dataFiltering();
                                          }
                                        },
                                      ),
                                    )
                              : const SizedBox(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
