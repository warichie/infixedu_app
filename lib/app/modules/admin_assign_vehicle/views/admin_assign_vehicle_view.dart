import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:get/get.dart';

import '../controllers/admin_assign_vehicle_controller.dart';

class AdminAssignVehicleView extends GetView<AdminAssignVehicleController> {
  const AdminAssignVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Assign Vehicle To Route".tr,
      body: CustomBackground(
        customWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Route".tr,
                  style: AppTextStyle.fontSize16lightBlackW500,
                ),
                10.h.verticalSpacing,
                Obx(
                  () => controller.dropdownLoader.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : DuplicateDropdown(
                          dropdownValue:
                              controller.assignRouteInitialValue.value,
                          dropdownList: controller.assignRouteList,
                          changeDropdownValue: (value) {
                            controller.assignRouteInitialValue.value = value!;
                            controller.routeId.value = value.id;
                          },
                        ),
                ),
                20.h.verticalSpacing,
                Text(
                  "Select Vehicle".tr,
                  style: AppTextStyle.fontSize16lightBlackW500,
                ),
                10.h.verticalSpacing,
                Obx(
                  () => controller.dropdownLoader.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : DuplicateDropdown(
                          dropdownValue:
                              controller.assignVehicleInitialValue.value,
                          dropdownList: controller.assignVehicleList,
                          changeDropdownValue: (value) {
                            controller.assignVehicleInitialValue.value = value!;
                            controller.vehicleId.value = value.id;
                          },
                        ),
                ),
                30.h.verticalSpacing,
                Obx(
                  () => controller.loadingController.isLoading
                      ? const SecondaryLoadingWidget(
                          isBottomNav: true,
                        )
                      : PrimaryButton(
                          text: "Save".tr,
                          onTap: () {
                            if (controller.assignRouteList.isNotEmpty &&
                                controller.assignVehicleList.isNotEmpty) {
                              controller.addAssignVehicleToRoute(
                                routeId: controller.routeId.value,
                                vehicleId: controller.vehicleId.value,
                              );
                            }
                          },
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
