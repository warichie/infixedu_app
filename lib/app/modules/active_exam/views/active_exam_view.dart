import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/modules/active_exam/views/widget/active_exam_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/study_button/study_button.dart';
import '../controllers/active_exam_controller.dart';

class ActiveExamView extends GetView<ActiveExamController> {
  const ActiveExamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Active Exam".tr,
        body: CustomBackground(
          customWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              0.verticalSpacing,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        controller.homeController.studentRecordList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5),
                        child: Obx(
                          () => StudyButton(
                            title:
                                "${"Class".tr} ${controller.homeController.studentRecordList[index].studentRecordClass}(${controller.homeController.studentRecordList[index].section})",
                            onItemTap: () {
                              controller.onlineActiveExamList.clear();
                              controller.selectIndex.value = index;
                              int recordId = controller
                                  .homeController.studentRecordList[index].id;
                              controller.getStudentActiveExamList(
                                  recordId: recordId);
                            },
                            isSelected: controller.selectIndex.value == index,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              controller.loadingController.isLoading
                  ? const Expanded(
                      child: LoadingWidget(),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        color: AppColors.primaryColor,
                        onRefresh: () async {
                          controller.onlineActiveExamList.clear();
                          controller.getStudentActiveExamList(
                              recordId: controller
                                  .homeController.studentRecordList[0].id);
                        },
                        child: controller.onlineActiveExamList.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    controller.onlineActiveExamList.length,
                                itemBuilder: (context, index) {
                                  String colorCode = '';
                                  if (controller
                                          .onlineActiveExamList[index].status ==
                                      'Closed') {
                                    colorCode = '0xFFF95452';
                                  } else if (controller
                                          .onlineActiveExamList[index].status ==
                                      'Already Submitted') {
                                    colorCode = '0xFF404FB6';
                                  } else if (controller
                                          .onlineActiveExamList[index].status ==
                                      'Take Exam') {
                                    colorCode = '0xFF943AE3';
                                  } else {
                                    colorCode = '0xFF412C56';
                                  }

                                  return ActiveExamTile(
                                    title: controller
                                        .onlineActiveExamList[index].title,
                                    subject: controller
                                        .onlineActiveExamList[index].subject,
                                    startingTime: controller
                                        .onlineActiveExamList[index].startTime,
                                    startDate: controller
                                        .onlineActiveExamList[index].startDate,
                                    endDate: controller
                                        .onlineActiveExamList[index].endDate,
                                    endingTime: controller
                                        .onlineActiveExamList[index].endTime,
                                    activeStatus: controller
                                        .onlineActiveExamList[index].status?.tr,
                                    activeStatusColor:
                                        Color(int.tryParse(colorCode)!),
                                    color: index % 2 == 1
                                        ? Colors.white
                                        : AppColors.homeworkWidgetColor,
                                  );
                                },
                              )
                            : const Center(child: NoDataAvailableWidget()),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
