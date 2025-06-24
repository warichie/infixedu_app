import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/modules/student_search_attendance/views/widget/display_calender.dart';
import 'package:infixedu/app/modules/student_search_attendance/views/widget/event_status.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';

import 'package:get/get.dart';

import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../../../utilities/widgets/study_button/study_button.dart';
import '../controllers/student_search_attendance_controller.dart';

class StudentSearchAttendanceView
    extends GetView<StudentSearchAttendanceController> {
  const StudentSearchAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Attendance".tr,
      body: Obx(
        () => CustomBackground(
          customWidget: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(7.w),
                  child: SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          controller.homeController.studentRecordList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                              () => StudyButton(
                                title:
                                    "${"Class".tr} ${controller.homeController.studentRecordList[index].studentRecordClass}(${controller.homeController.studentRecordList[index].section})",
                                onItemTap: () {
                                  controller.selectIndex.value = index;
                                  controller.recordId.value = controller
                                      .homeController
                                      .studentRecordList[index]
                                      .id;

                                  controller.getAttendanceList(
                                    recordId: controller.recordId.toInt(),
                                    studentId: controller
                                        .globalRxVariableController
                                        .studentId
                                        .value!,
                                  );
                                },
                                isSelected:
                                    controller.selectIndex.value == index,
                              ),
                            ));
                      },
                    ),
                  ),
                ),
                controller.loadingController.isLoading
                    ? const SecondaryLoadingWidget()
                    : DisplayCalender(
                        currentDate: controller.currentDate,
                        eventList: controller.eventList,
                        onCalendarChanged: (DateTime date) {
                          controller.eventList?.clear();
                          if (controller.fromStatus.value) {
                            controller.getSearchSubjectAttendanceListWithDate(
                                recordId: controller.recordId.toInt(),
                                studentId: controller.globalRxVariableController
                                    .studentId.value!,
                                year: date.year,
                                month: date.month,
                                subjectId: controller.subjectId!);
                          } else {
                            controller
                                .getAttendanceListWithDate(
                                  recordId: controller.recordId.toInt(),
                                  studentId: controller
                                      .globalRxVariableController
                                      .studentId
                                      .value!,
                                  year: date.year,
                                  month: date.month,
                                )
                                .then((value) => controller.setEventData());
                          }
                        },
                      ),
                EventStatus(
                  color: const Color(0xFF00C106),
                  title: "Present".tr,
                  numberOfDays: controller.present.value,
                ),
                EventStatus(
                  color: const Color(0xFF5057FC),
                  title: "Half Day".tr,
                  numberOfDays: controller.halfDay.value,
                ),
                EventStatus(
                  color: const Color(0xFFFF6F00),
                  title: "Late".tr,
                  numberOfDays: controller.late.value,
                ),
                EventStatus(
                  color: const Color(0xFFF32E21),
                  title: "Absent".tr,
                  numberOfDays: controller.absent.value,
                ),
                EventStatus(
                  color: const Color(0xFF462564),
                  title: "Holiday".tr,
                  numberOfDays: controller.holiday.value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
