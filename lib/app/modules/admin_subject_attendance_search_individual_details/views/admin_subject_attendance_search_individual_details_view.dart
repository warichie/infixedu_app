import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/modules/student_search_attendance/views/widget/display_calender.dart';
import 'package:infixedu/app/modules/student_search_attendance/views/widget/event_status.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/study_button/study_button.dart';

import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_individual_details_controller.dart';

class AdminSubjectAttendanceSearchIndividualDetailsView
    extends GetView<AdminSubjectAttendanceSearchIndividualDetailsController> {
  const AdminSubjectAttendanceSearchIndividualDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Attendance".tr,
      body: Obx(() => CustomBackground(
            customWidget: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 40.h,
                      width: 100.w,
                      child: StudyButton(
                        title: controller.classSection.value,
                        onItemTap: () {},
                        isSelected: true,
                      ),
                    ),
                  ),
                  controller.isLoading.value
                      ? const SecondaryLoadingWidget()
                      : DisplayCalender(
                          currentDate: controller.currentDate,
                          eventList: controller.eventList,
                          onCalendarChanged: (DateTime date) {
                            controller.eventList!.clear();
                            controller
                                .getAdminAttendanceSubDetailsListWithDate(
                                  recordId: controller.recordId.value,
                                  subjectNameId: controller.subjectNameId.value,
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
