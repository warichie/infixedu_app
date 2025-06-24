import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/domain/core/model/student_lesson_plan_response_model/student_lesson_plan_response_model.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../../../utilities/widgets/show_week_tile/show_week_tile.dart';
import '../../../utilities/widgets/student_class_details_card/student_class_details_card.dart';
import '../../../utilities/widgets/study_button/study_button.dart';
import '../controllers/student_lesson_plan_controller.dart';

class StudentLessonPlanView extends GetView<StudentLessonPlanController> {
  const StudentLessonPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        initialIndex: controller.selectTabIndex.value,
        length: controller.daysOfWeek.length,
        child: InfixEduScaffold(
          title: "Lesson Plan".tr,
          body: CustomBackground(
            customWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              child: controller.lessonLoader.value
                  ? Center(
                      child: Platform.isAndroid
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.primaryColor,
                              ),
                            ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 34.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller
                                .homeController.studentRecordList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: StudyButton(
                                  title:
                                      "${"Class".tr} ${controller.homeController.studentRecordList[index].studentRecordClass}(${controller.homeController.studentRecordList[index].section})",
                                  onItemTap: () {
                                    controller.weeksList.clear();
                                    int recordId = controller.homeController
                                        .studentRecordList[index].id;
                                    controller.getLessonPlanList(
                                      studentId: controller
                                          .globalRxVariableController
                                          .studentId
                                          .value!,
                                      recordId: recordId,
                                      date: DateTime.now().yyyy_mm_dd,
                                    );
                                    controller.selectIndex.value = index;
                                  },
                                  isSelected:
                                      controller.selectIndex.value == index,
                                ),
                              );
                            },
                          ),
                        ),
                        20.h.verticalSpacing,
                        Text(
                          controller.formattedDate,
                          style: AppTextStyle.fontSize14VioletW600,
                        ),
                        20.h.verticalSpacing,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.profileCardTextColor),
                          ),
                          child: SizedBox(
                            // height: 28.h,
                            child: TabBar(
                              isScrollable: true,
                              padding: EdgeInsets.symmetric(horizontal: 7.w),
                              tabAlignment: TabAlignment.start,
                              dividerHeight: 0,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              controller: controller.tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.lessonButtonColor),
                              tabs: List.generate(
                                // controller.daysOfWeek.length,
                                controller.weeksList.length ?? 0,
                                (index) => ShowWeekTile(
                                  // title: controller.daysOfWeek[index].tr,
                                  title: (controller.weeksList[index].name ??
                                          '   ')
                                      .substring(0, 3)
                                      .tr,
                                ),
                              ),
                            ),
                          ),
                        ),
                        10.h.verticalSpacing,
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            children: List.generate(
                              controller.daysOfWeek.length,
                              (index) {
                                List<Weeks> weeksList = controller.weeksList
                                    .where((element) =>
                                        element.name?.substring(0, 3) ==
                                        controller.daysOfWeek[index])
                                    .toList();

                                return Obx(
                                  () => controller.loadingController.isLoading
                                      ? const LoadingWidget()
                                      : weeksList.isNotEmpty
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: controller
                                                      .weeksList[index]
                                                      .classRoutine
                                                      ?.length ??
                                                  0,
                                              itemBuilder:
                                                  (context, routineIndex) {
                                                if (controller.weeksList[index]
                                                    .classRoutine!.isNotEmpty) {
                                                  ClassRoutine classRoutine =
                                                      controller
                                                                  .weeksList[index]
                                                                  .classRoutine?[
                                                              routineIndex] ??
                                                          ClassRoutine();
                                                  return StudentClassDetailsCard(
                                                    subject: classRoutine
                                                        .subjectName,
                                                    startingTime:
                                                        classRoutine.startTime,
                                                    endingTime:
                                                        classRoutine.endTime,
                                                    roomNumber:
                                                        classRoutine.room,
                                                    buildingName:
                                                        "Building No".tr,
                                                    instructorName:
                                                        classRoutine.teacher,
                                                    onDetailsButtonTap:
                                                        controller
                                                            .isLoading.value,
                                                    hasDetails: true,
                                                    onTap: () {
                                                      controller.getLessonPlanListDetails(
                                                          subjectId: classRoutine
                                                                  .subjectId ??
                                                              0,
                                                          studentId: controller
                                                              .globalRxVariableController
                                                              .studentId
                                                              .value!,
                                                          date: controller
                                                                  .weeksList[
                                                                      index]
                                                                  .date ??
                                                              '',
                                                          context: context);
                                                    },
                                                    buttonWidget: controller
                                                            .isLoading.value
                                                        ? const CircularProgressIndicator()
                                                        : Container(
                                                            height: 22.h,
                                                            alignment: Alignment
                                                                .center,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5.w),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2),
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                            child: Text(
                                                              "Details".tr,
                                                              style: AppTextStyle
                                                                  .textStyle10WhiteW400,
                                                            ),
                                                          ),
                                                  );
                                                }
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30.0),
                                                  child: Center(
                                                      child: Text(
                                                    'No Data Available'.tr,
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                );
                                              },
                                            )
                                          : const SingleChildScrollView(
                                              child: NoDataAvailableWidget()),
                                );
                              },
                            ),
                          ),
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
