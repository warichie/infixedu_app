import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/result/views/widget/result_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/study_button/study_button.dart';
import 'package:get/get.dart';
import '../../../utilities/widgets/loader/loading.widget.dart';
import '../../../utilities/widgets/no_data_available/no_data_available_widget.dart';
import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Result".tr,
      body: CustomBackground(
        customWidget: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.h.verticalSpacing,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.0, vertical: 10),
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
                              controller.examinationController.examDropdownList
                                  .clear();
                              int recordId = controller
                                  .homeController.studentRecordList[index].id;
                              controller.examinationController
                                  .getStudentExamList(recordId: recordId);
                            },
                            isSelected: controller.selectIndex.value == index,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              controller.examinationController.loadingController.isLoading
                  ? const SecondaryLoadingWidget()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: DuplicateDropdown(
                        dropdownValue: controller
                            .examinationController.dropdownValue.value,
                        dropdownList:
                            controller.examinationController.dropdownList,
                        changeDropdownValue: (v) {
                          controller.examinationController.dropdownValue.value =
                              v!;
                          controller.examResultList.clear();
                          int examId = v.id;
                          int recordId =
                              controller.homeController.studentRecordList[0].id;
                          controller.getStudentExamResultList(
                            typeId: examId,
                            recordId: recordId,
                          );
                        },
                      ),
                    ),
              20.h.verticalSpacing,
              controller.loadingController.isLoading
                  ? const Expanded(
                      child: LoadingWidget(),
                    )
                  : controller.examResultList.isNotEmpty
                      ? Expanded(
                          child: RefreshIndicator(
                            color: AppColors.primaryColor,
                            onRefresh: () async {
                              controller.examResultList.clear();
                              controller.getStudentExamResultList(
                                typeId: controller.currentExamId!,
                                recordId: controller.currentRecordId!,
                              );
                            },
                            child: ListView.builder(
                              itemCount: controller.examResultList.length,
                              itemBuilder: (context, int index) {
                                return ResultTile(
                                  title:
                                      controller.examResultList[index].examName,
                                  subject: controller
                                      .examResultList[index].subjectName,
                                  totalMarks: controller
                                      .examResultList[index].totalMarks,
                                  obtainMarks: controller
                                      .examResultList[index].obtainedMarks,
                                  grade: controller.examResultList[index].grade,
                                  color: index % 2 == 0
                                      ? AppColors.profileCardTextColor
                                      : Colors.white,
                                );
                              },
                            ),
                          ),
                        )
                      : const Center(
                          child: NoDataAvailableWidget(),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
