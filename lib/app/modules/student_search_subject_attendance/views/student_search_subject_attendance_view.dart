import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/modules/student_search_subject_attendance/views/widgets/search_details_tile.dart';
import 'package:infixedu/app/modules/student_search_subject_attendance/views/widgets/subject_card_title.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../../../utilities/widgets/study_button/study_button.dart';
import '../controllers/student_search_subject_attendance_controller.dart';

class StudentSearchSubjectAttendanceView
    extends GetView<StudentSearchSubjectAttendanceController> {
  const StudentSearchSubjectAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Select Subject".tr,
        body: CustomBackground(
          customWidget: Column(
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
                        child: StudyButton(
                          title:
                              "${"Class".tr} ${controller.homeController.studentRecordList[index].studentRecordClass}(${controller.homeController.studentRecordList[index].section})",
                          onItemTap: () {
                            controller.selectIndex.value = index;
                            controller.recordId.value = controller
                                .homeController.studentRecordList[index].id;

                            controller.subjectsController.getAllSubjectList(
                                recordId: controller.recordId.toInt());
                          },
                          isSelected: controller.selectIndex.value == index,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Card(
                elevation: 3.5,
                margin: EdgeInsets.zero,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: Get.height * 0.09,
                  color: AppColors.profileCardTextColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubjectCardTitle(
                        title: 'Subject'.tr,
                      ),
                      5.horizontalSpacing,
                      SubjectCardTitle(
                        title: 'Teacher'.tr,
                      ),
                      5.horizontalSpacing,
                      SubjectCardTitle(
                        title: 'Type'.tr,
                      ),
                    ],
                  ),
                ),
              ),
              10.verticalSpacing,
              controller.subjectsController.loadingController.isLoading
                  ? const SecondaryLoadingWidget()
                  : controller.subjectsController.subjectList.isNotEmpty
                      ? Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              controller.subjectsController.getAllSubjectList(
                                recordId: controller.recordId.toInt(),
                              );
                            },
                            child: ListView.builder(
                              itemCount: controller
                                  .subjectsController.subjectList.length,
                              itemBuilder: (context, index) {
                                return SearchDetailsTile(
                                  subject: controller.subjectsController
                                      .subjectList[index].subject,
                                  teacher: controller.subjectsController
                                      .subjectList[index].teacher,
                                  lectureType: controller.subjectsController
                                      .subjectList[index].type,
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.STUDENT_SEARCH_ATTENDANCE,
                                      arguments: {
                                        "subjectID": controller
                                            .subjectsController
                                            .subjectList[index]
                                            .id,
                                        "from": true
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      : const NoDataAvailableWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
