import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/widgets/show_week_tile/show_week_tile.dart';
import 'package:infixedu/app/utilities/widgets/student_class_details_card/student_class_details_card.dart';
import 'package:infixedu/domain/core/model/teacher/teacher_academic_model/teacher_class_routine_list_response_model.dart';

import 'package:get/get.dart';

import '../../routine/controllers/routine_controller.dart';
import '../controllers/te_search_class_routine_list_controller.dart';

class TeSearchClassRoutineListView
    extends GetView<TeSearchClassRoutineListController> {
  const TeSearchClassRoutineListView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: controller.selectIndex.value,
      length: daysOfWeek.length,
      child: InfixEduScaffold(
        title: "Class Routine".tr,
        body: Obx(
          () => CustomBackground(
            customWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Text(
                    controller.formattedDate,
                    style: AppTextStyle.fontSize14VioletW600,
                  ),
                  20.verticalSpacing,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.profileCardTextColor),
                    ),
                    child: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerHeight: 0,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      controller: controller.tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.appButtonColor),
                      tabs: List.generate(
                        daysOfWeek.length,
                        (index) => ShowWeekTile(
                          title: daysOfWeek[index].tr,
                        ),
                      ),
                    ),
                  ),
                  10.verticalSpacing,
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: List.generate(
                        daysOfWeek.length,
                        (index) {
                          List<TeacherClassRoutines>? routineList = controller
                              .teacherClassRoutineList
                              .where((element) =>
                                  element.day?.substring(0, 3) ==
                                  daysOfWeek[index])
                              .toList();

                          return controller.isLoading.value
                              ? const SecondaryLoadingWidget()
                              : routineList.isNotEmpty
                                  ? RefreshIndicator(
                                      color: AppColors.primaryColor,
                                      onRefresh: () async {
                                        controller.teacherClassRoutineList
                                            .clear();
                                        controller.getTeacherClassRoutineList(
                                          classId: controller
                                              .adminStudentsSearchController
                                              .studentClassId
                                              .value,
                                          sectionId: controller
                                              .adminStudentsSearchController
                                              .studentSectionId
                                              .value,
                                        );
                                      },
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: routineList.length,
                                        itemBuilder: (context, index) {
                                          return StudentClassDetailsCard(
                                            startingTime:
                                                routineList[index].startTime,
                                            subject: routineList[index].subject,
                                            endingTime:
                                                routineList[index].endTime,
                                            roomNumber: routineList[index].room,
                                            buildingName: '',
                                            instructorName:
                                                routineList[index].teacher,
                                          );
                                        },
                                      ),
                                    )
                                  : const NoDataAvailableWidget();
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
