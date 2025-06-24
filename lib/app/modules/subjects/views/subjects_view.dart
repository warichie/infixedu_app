import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/subjects/views/widget/subject_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_text_style.dart';
import '../controllers/subjects_controller.dart';

class SubjectsView extends GetView<SubjectsController> {
  const SubjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Subjects".tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            Card(
              elevation: 5,
              margin: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.all(15),
                height: 69.h,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: AppColors.profileCardTextColor),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Subject".tr,
                          style: AppTextStyle.fontSize13BlackW500,
                        ),
                      ),
                    ),
                    5.w.horizontalSpacing,
                    SizedBox(
                      width: Get.width * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Teacher".tr,
                          style: AppTextStyle.fontSize13BlackW500,
                        ),
                      ),
                    ),
                    5.w.horizontalSpacing,
                    Flexible(
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            "Type".tr,
                            style: AppTextStyle.fontSize13BlackW500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.w.verticalSpacing,
            Obx(
              () => controller.loadingController.isLoading
                  ? const Expanded(
                      child: LoadingWidget(),
                    )
                  : controller.subjectList.isNotEmpty
                      ? Expanded(
                          child: RefreshIndicator(
                            color: AppColors.primaryColor,
                            onRefresh: () async {
                              controller.subjectList.clear();
                              controller.getAllSubjectList(
                                  recordId: controller
                                      .homeController.studentRecordIdList[0]);
                            },
                            child: ListView.builder(
                              itemCount: controller.subjectList.length,
                              itemBuilder: (context, index) {
                                return SubjectTile(
                                  subject:
                                      controller.subjectList[index].subject,
                                  teacher:
                                      controller.subjectList[index].teacher,
                                  lectureType:
                                      controller.subjectList[index].type,
                                );
                              },
                            ),
                          ),
                        )
                      : const NoDataAvailableWidget(),
            ),
            20.h.verticalSpacing,
          ],
        ),
      ),
    );
  }
}
