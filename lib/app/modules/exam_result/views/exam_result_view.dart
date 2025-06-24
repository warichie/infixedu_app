import 'package:flutter/material.dart';
import 'package:infixedu/app/modules/exam_result/views/widget/exam_result_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../controllers/exam_result_controller.dart';

class ExamResultView extends GetView<ExamResultController> {
  const ExamResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Exam Result".tr,
        body: CustomBackground(
          customWidget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpacing,
              controller.loadingController.isLoading
                  ? const Expanded(
                      child: LoadingWidget(),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          controller.onlineExamResultList.clear();
                          controller.getStudentExamResultList(
                            studentId: controller
                                .globalRxVariableController.studentId.value!,
                          );
                        },
                        child: controller.onlineExamResultList.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    controller.onlineExamResultList.length,
                                itemBuilder: (context, index) {
                                  return ExamResultTile(
                                    title: controller
                                        .onlineExamResultList[index].title,
                                    startingTime: controller
                                        .onlineExamResultList[index].examTime,
                                    endingTime: controller
                                        .onlineExamResultList[index].endTime,
                                    startDate: controller
                                        .onlineExamResultList[index].startDate,
                                    endDate: controller
                                        .onlineExamResultList[index].endDate,
                                    result: controller
                                        .onlineExamResultList[index].result,
                                    activeStatusColor: controller
                                                .onlineExamResultList[index]
                                                .result ==
                                            'Fail'
                                        ? AppColors.homeworkStatusRedColor
                                        : AppColors.homeworkStatusGreenColor,
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : AppColors.homeworkWidgetColor,
                                  );
                                },
                              )
                            : const Center(child: NoDataAvailableWidget()),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
