import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/modules/schedule/views/widget/schedule_details_tile.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/widgets/study_button/study_button.dart';
import 'package:get/get.dart';
import '../controllers/schedule_controller.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Schedule".tr,
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getStudentExamScheduleList(
                examId: controller.examList[0].id!,
                recordId: controller.homeController.studentRecordList[0].id);
          },
          child: CustomBackground(
            customWidget: Column(
              children: [
                controller.homeController.loadingController.isLoading
                    ? SizedBox(
                        height: 55.h,
                        child: LoadingWidget(),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 7.0.w, vertical: 7.w),
                        child: SizedBox(
                          height: 55.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller
                                .homeController.studentRecordList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(
                                  () => StudyButton(
                                    title:
                                        "${"Class".tr} ${controller.homeController.studentRecordList[index].studentRecordClass}(${controller.homeController.studentRecordList[index].section})",
                                    onItemTap: () {
                                      controller.selectIndex.value = index;
                                      controller.examDropdownList.clear();
                                      int recordId = controller.homeController
                                          .studentRecordList[index].id;
                                      controller.getStudentExamList(
                                          recordId: recordId);
                                    },
                                    isSelected:
                                        controller.selectIndex.value == index,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                controller.examLoader.value
                    ? const SecondaryLoadingWidget()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: DuplicateDropdown(
                          dropdownValue: controller.dropdownValue.value,
                          dropdownList: controller.examList,
                          changeDropdownValue: (v) {
                            controller.dropdownValue.value = v!;
                            controller.scheduleList.clear();
                            controller.examinationId.value = v.id;
                            int recordId = controller
                                .homeController.studentRecordList[0].id;
                            controller.getStudentExamScheduleList(
                              examId: controller.examinationId.value,
                              recordId: recordId,
                            );
                          },
                        ),
                      ),
                Expanded(
                  child: RefreshIndicator(
                    color: AppColors.primaryColor,
                    onRefresh: () async {
                      controller.scheduleList.clear();
                      controller.getStudentExamScheduleList(
                          examId: controller.examinationId.value,
                          recordId: controller
                              .homeController.studentRecordList[0].id);
                    },
                    child: controller.scheduleLoader.value
                        ? const SecondaryLoadingWidget()
                        : controller.scheduleList.isNotEmpty
                            ? ListView.builder(
                                itemCount: controller.scheduleList.length,
                                itemBuilder: (context, index) {
                                  return ScheduleDetailsTile(
                                    date: controller
                                        .scheduleList[index].dateAndDay,
                                    subject:
                                        controller.scheduleList[index].subject,
                                    startTime: controller
                                        .scheduleList[index].startTime,
                                    endTime:
                                        controller.scheduleList[index].endTime,
                                    roomNo: controller.scheduleList[index].room,
                                    section: controller
                                        .scheduleList[index].classSection,
                                    teacher:
                                        controller.scheduleList[index].teacher,
                                    color: index % 2 == 0
                                        ? AppColors.profileCardTextColor
                                        : Colors.white,
                                  );
                                },
                              )
                            : const NoDataAvailableWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
