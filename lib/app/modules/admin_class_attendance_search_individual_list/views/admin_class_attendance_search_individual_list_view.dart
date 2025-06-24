import 'package:flutter/material.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/widgets/student_list_tile/student_list_tile.dart';

import 'package:get/get.dart';

import '../controllers/admin_class_attendance_search_individual_list_controller.dart';

class AdminClassAttendanceSearchIndividualListView
    extends GetView<AdminClassAttendanceSearchIndividualListController> {
  const AdminClassAttendanceSearchIndividualListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Students List".tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            Obx(
              () => Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : controller.adminStudentIndividualList.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  controller.adminStudentIndividualList.length,
                              itemBuilder: (context, index) {
                                return StudentListTile(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes
                                          .ADMIN_CLASS_ATTENDANCE_INDIVIDUAL_DETAILS,
                                      arguments: {
                                        'student_attendance_id': controller
                                            .adminStudentIndividualList[index]
                                            .id,
                                      },
                                    );
                                  },
                                  studentName: controller
                                      .adminStudentIndividualList[index]
                                      .fullName,
                                  imageURL: controller
                                      .adminStudentIndividualList[index]
                                      .studentPhoto,
                                  classSection: controller
                                      .adminStudentIndividualList[index]
                                      .section,
                                  studentClass: controller
                                      .adminStudentIndividualList[index]
                                      .className,
                                );
                              },
                            )
                          : const NoDataAvailableWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
