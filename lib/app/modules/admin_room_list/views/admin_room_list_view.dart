import 'package:flutter/material.dart';
import 'package:infixedu/app/utilities/widgets/dormitory_card_tile/dormitory_card_tile.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_room_list_controller.dart';

class AdminRoomListView extends GetView<AdminRoomListController> {
  const AdminRoomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Room List".tr,
        body: CustomBackground(
          customWidget: Column(
            children: [
              controller.loadingController.isLoading
                  ? const Expanded(child: LoadingWidget())
                  : Expanded(
                      child: controller.dormitoryRoomList.isNotEmpty
                          ? RefreshIndicator(
                              onRefresh: () async {
                                controller.getDormitoryRoomList();
                              },
                              child: ListView.builder(
                                itemCount: controller.dormitoryRoomList.length,
                                itemBuilder: (context, index) {
                                  return DormitoryCardTile(
                                    dormitoryName: controller
                                        .dormitoryRoomList[index].dormitory,
                                    roomNoName:
                                        '${controller.dormitoryRoomList[index].name}',
                                    cost: controller
                                        .dormitoryRoomList[index].costPerBed,
                                    numberOfBed: controller
                                        .dormitoryRoomList[index].numberOfBed,
                                    roomType: controller
                                        .dormitoryRoomList[index].roomType,
                                    isAdminRoomList: true,
                                  );
                                },
                              ),
                            )
                          : const NoDataAvailableWidget(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
