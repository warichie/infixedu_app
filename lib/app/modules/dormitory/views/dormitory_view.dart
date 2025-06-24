import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/widgets/dormitory_card_tile/dormitory_card_tile.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/dormitory_controller.dart';

class DormitoryView extends GetView<DormitoryController> {
  const DormitoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Dormitory".tr,
        body: CustomBackground(
          customWidget: Column(
            children: [
              controller.loadingController.isLoading
                  ? const Expanded(
                      child: LoadingWidget(),
                    )
                  : controller.dormitoryList.isNotEmpty
                      ? Expanded(
                          child: RefreshIndicator(
                            color: AppColors.primaryColor,
                            onRefresh: () async {
                              controller.dormitoryList.clear();
                              controller.getDormitoryList();
                            },
                            child: ListView.builder(
                              itemCount: controller.dormitoryList.length,
                              itemBuilder: (context, index) {
                                return DormitoryCardTile(
                                  dormitoryName: controller
                                      .dormitoryList[index].dormitoryName,
                                  roomNoName: controller
                                      .dormitoryList[index].roomNumber,
                                  numberOfBed: controller
                                      .dormitoryList[index].numberOfBed,
                                  cost: controller
                                      .dormitoryList[index].costPerBed,
                                  activeStatus: controller
                                      .dormitoryList[index].status?.tr,
                                  activeStatusColor: AppColors.primaryColor,
                                );
                              },
                            ),
                          ),
                        )
                      : const NoDataAvailableWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
