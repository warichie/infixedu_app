import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/student_search_attendance/views/widget/display_calender.dart';
import 'package:infixedu/app/modules/student_search_attendance/views/widget/event_status.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/study_button/study_button.dart';

import 'package:get/get.dart';

import '../controllers/admin_class_attendance_individual_details_controller.dart';

class AdminClassAttendanceIndividualDetailsView
    extends GetView<AdminClassAttendanceIndividualDetailsController> {
  const AdminClassAttendanceIndividualDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Attendance".tr,
      body: Obx(() => CustomBackground(
            customWidget: SingleChildScrollView(
              child: controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ))
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 0),
                          child: SizedBox(
                            height: 50.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Obx(
                                      () => StudyButton(
                                        title: controller.classSection.value,
                                        onItemTap: () {
                                          controller.selectIndex.value = index;
                                        },
                                        isSelected:
                                            controller.selectIndex.value ==
                                                index,
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ),
                        DisplayCalender(
                          currentDate: controller.currentDate,
                          eventList: controller.eventList,
                          onCalendarChanged: (DateTime date) {
                            controller.eventList!.clear();
                            controller
                                .getAdminStudentSearchAttendanceDetailsListWithDate(
                                  studentAttendanceId:
                                      controller.studentAttendanceId.value,
                                  month: date.month,
                                  year: date.year,
                                )
                                .then((value) => controller.setEventData());
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
          )),
    );
  }
}
