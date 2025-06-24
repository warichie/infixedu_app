import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/staff_list/views/widget/staff_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/staff_list_controller.dart';

class StaffListView extends GetView<StaffListController> {
  const StaffListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "${controller.staffDesignation.tr} ${"List".tr}",
      body: CustomBackground(
        customWidget: Column(
          children: [
            10.h.verticalSpacing,
            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : controller.roleWiseStaffList.isNotEmpty
                      ? Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              controller.roleWiseStaffList.clear();
                              controller.getRoleWiseStaffList(
                                  staffRoleId: controller.staffId);
                            },
                            child: ListView.separated(
                              itemCount: controller.roleWiseStaffList.length,
                              itemBuilder: (context, index) {
                                return StaffTile(
                                  staffName: controller
                                      .roleWiseStaffList[index].firstName,
                                  staffAddress: controller
                                      .roleWiseStaffList[index].currentAddress,
                                  staffPhoneNo: controller
                                      .roleWiseStaffList[index].mobile,
                                  isImageEmpty: controller
                                                  .roleWiseStaffList[index]
                                                  .staffPhoto
                                                  ?.toString() ==
                                              null ||
                                          controller.roleWiseStaffList[index]
                                              .staffPhoto
                                              .toString()
                                              .isEmpty
                                      ? false
                                      : true,
                                  imageUrl: controller
                                      .roleWiseStaffList[index].staffPhoto
                                      .toString(),
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.STAFF_INDIVIDUAL_DETAILS,
                                      arguments: {
                                        "staff_individual_id": controller
                                            .roleWiseStaffList[index].id,
                                        "staff_first_name": controller
                                            .roleWiseStaffList[index].firstName,
                                        "staff_last_name": controller
                                            .roleWiseStaffList[index].lastName,
                                        "staff_image": controller
                                            .roleWiseStaffList[index]
                                            .staffPhoto,
                                      },
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (_, __) => 2.verticalSpacing,
                            ),
                          ),
                        )
                      : NoDataAvailableWidget(
                          message: "No staff list available".tr,
                        ),
            )
          ],
        ),
      ),
    );
  }
}
