import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/modules/subjects/views/widget/subject_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_subjects_controller.dart';

class TeSubjectsView extends GetView<TeSubjectsController> {
  const TeSubjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Subject".tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            Card(
              elevation: 5,
              margin: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.all(15),
                height: 70.h,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: AppColors.profileCardTextColor),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.25,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Subject".tr,
                          style: AppTextStyle.fontSize14BlackW500,
                        ),
                      ),
                    ),
                    5.horizontalSpacing,
                    SizedBox(
                      width: Get.width * 0.25,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Teacher".tr,
                          style: AppTextStyle.fontSize14BlackW500,
                        ),
                      ),
                    ),
                    5.horizontalSpacing,
                    SizedBox(
                      width: Get.width * 0.25,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Type".tr,
                          style: AppTextStyle.fontSize14BlackW500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.verticalSpacing,
            Obx(
              () => controller.loadingController.isLoading
                  ? const Expanded(child: LoadingWidget())
                  : controller.teacherSubjectList.isNotEmpty
                      ? Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              controller.getTeacherSubjectList();
                            },
                            child: ListView.builder(
                              itemCount: controller.teacherSubjectList.length,
                              itemBuilder: (context, index) {
                                return SubjectTile(
                                  subject: controller
                                      .teacherSubjectList[index].subjectName,
                                  teacher: controller
                                      .teacherSubjectList[index].subjectCode,
                                  lectureType: controller
                                      .teacherSubjectList[index].subjectType,
                                );
                              },
                            ),
                          ),
                        )
                      : const NoDataAvailableWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
