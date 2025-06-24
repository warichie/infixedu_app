import 'package:flutter/material.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/student_list_tile/student_list_tile.dart';

import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_individual_list_controller.dart';

class AdminSubjectAttendanceSearchIndividualListView
    extends GetView<AdminSubjectAttendanceSearchIndividualListController> {
  const AdminSubjectAttendanceSearchIndividualListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Students List".tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  itemCount: controller.adminSubAttendanceList.length,
                  itemBuilder: (context, index) {
                    return StudentListTile(
                      onTap: () {
                        // print(controller.subjectNameId.value);
                        Get.toNamed(
                            Routes
                                .ADMIN_SUBJECT_ATTENDANCE_SEARCH_INDIVIDUAL_DETAILS,
                            arguments: {
                              'record_id': controller
                                  .adminSubAttendanceList[index].recordId,
                              'subject_name_id': controller.subjectNameId.value,
                            });
                      },
                      studentName:
                          controller.adminSubAttendanceList[index].fullName,
                      imageURL:
                          controller.adminSubAttendanceList[index].studentPhoto,
                      classSection:
                          controller.adminSubAttendanceList[index].section,
                      studentClass:
                          controller.adminSubAttendanceList[index].className,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
