import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/teacher/views/widget/teacher_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';

import 'package:get/get.dart';

import '../../../utilities/widgets/no_data_available/no_data_available_widget.dart';
import '../../../utilities/widgets/study_button/study_button.dart';
import '../controllers/teacher_controller.dart';

class TeacherView extends GetView<TeacherController> {
  const TeacherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Teacher".tr,
        body: CustomBackground(
          customWidget: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {
              controller.teacherList.clear();
              controller.getAllTeacherList(
                  recordId: controller.homeController.studentRecordList[0].id);
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  10.h.verticalSpacing,
                  SizedBox(
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
                              controller.teacherList.clear();
                              int recordId = controller
                                  .homeController.studentRecordList[index].id;
                              controller.getAllTeacherList(recordId: recordId);
                              controller.selectIndex.value = index;
                            },
                            isSelected: controller.selectIndex.value == index,
                          ),
                        );
                      },
                    ),
                  ),
                  10.verticalSpacing,
                  controller.loadingController.isLoading
                      ? SizedBox(
                          height: Get.height - 200.w,
                          child: const LoadingWidget(),
                        )
                      : controller.teacherList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.teacherList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10),
                                  child: TeacherTile(
                                    teachersName:
                                        controller.teacherList[index].fullName,
                                    subjectName: controller
                                        .teacherList[index].subjectName,
                                    teachersEmail:
                                        controller.teacherList[index].email,
                                    teachersPhoneNo:
                                        controller.teacherList[index].mobile,
                                    tileBackgroundColor: Colors.white,
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: NoDataAvailableWidget(),
                            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
