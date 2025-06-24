import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/appbar/back_button_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/widgets/show_week_tile/show_week_tile.dart';
import 'package:get/get.dart';
import '../../../../domain/core/model/student_routine_model/student_routine_response_model.dart';
import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/student_class_details_card/student_class_details_card.dart';
import '../controllers/routine_controller.dart';

class RoutineView extends GetView<RoutineController> {
  const RoutineView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: controller.selectIndex.value,
        length: daysOfWeek.length,
        child: Obx(() => InfixEduScaffold(
              title: controller.globalRxVariableController.roleId.value == 4
                  ? "My Routine".tr
                  : "Routine".tr,
              leadingIcon:
                  controller.globalRxVariableController.roleId.value == 4
                      ? const BackButtonWidget()
                      : const SizedBox(),
              body: Obx(
                () => CustomBackground(
                  customWidget: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: controller.loadingController.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          )
                        : Column(
                            children: [
                              Text(
                                controller.formattedDate,
                                style: AppTextStyle.fontSize14VioletW600,
                              ),
                              20.verticalSpacing,
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: AppColors.profileCardTextColor),
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
                                      List<ClassRoutine> routineList =
                                          controller.classRoutineList
                                              .where((element) =>
                                                  element.day
                                                      ?.substring(0, 3) ==
                                                  daysOfWeek[index])
                                              .toList();

                                      return controller
                                              .loadingController.isLoading
                                          ? const SecondaryLoadingWidget()
                                          : routineList.isNotEmpty
                                              ? RefreshIndicator(
                                                  color: AppColors.primaryColor,
                                                  onRefresh: () async {
                                                    controller.classRoutineList
                                                        .clear();
                                                    controller.getRoutineList();
                                                  },
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        routineList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return StudentClassDetailsCard(
                                                        subject:
                                                            routineList[index]
                                                                .subject,
                                                        startingTime:
                                                            routineList[index]
                                                                .startTime,
                                                        endingTime:
                                                            routineList[index]
                                                                .endTime,
                                                        roomNumber:
                                                            routineList[index]
                                                                .room,
                                                        instructorName:
                                                            routineList[index]
                                                                .teacher,
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
            )));
  }
}
