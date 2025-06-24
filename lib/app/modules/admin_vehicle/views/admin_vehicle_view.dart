import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_vehicle_controller.dart';
import 'widget/vehicle_tile.dart';

class AdminVehicleView extends GetView<AdminVehicleController> {
  const AdminVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: Obx(
        () => InfixEduScaffold(
          title: "Add Vehicle".tr,
          body: SingleChildScrollView(
            child: CustomBackground(
              customWidget: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0.w, vertical: 10.w),
                    child: TabBar(
                      labelColor: AppColors.profileValueColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerHeight: 0,
                      unselectedLabelColor: Colors.black,
                      unselectedLabelStyle:
                          AppTextStyle.fontSize12LightGreyW500,
                      labelStyle: AppTextStyle.fontSize12LightGreyW500,
                      indicatorColor: AppColors.profileIndicatorColor,
                      controller: controller.tabController,
                      tabs: List.generate(
                        controller.tabs.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            controller.tabs[index].tr,
                          ),
                        ),
                      ),
                      onTap: (index) {
                        controller.tabIndex.value = index;
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        /// Add Vehicle
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFormField(
                                controller: controller.vehicleNoTextController,
                                enableBorderActive: true,
                                focusBorderActive: true,
                                hintText: '${"Vehicle No".tr} *',
                              ),
                              10.h.verticalSpacing,
                              CustomTextFormField(
                                controller:
                                    controller.vehicleModelTextController,
                                enableBorderActive: true,
                                focusBorderActive: true,
                                hintText: "${"Vehicle Model".tr} *",
                              ),
                              10.h.verticalSpacing,
                              CustomTextFormField(
                                controller: controller.madeYearTextController,
                                enableBorderActive: true,
                                focusBorderActive: true,
                                hintText: "Made Year".tr,
                                textInputType: TextInputType.number,
                              ),
                              10.h.verticalSpacing,

                              Text(
                                "Add Driver Name".tr,
                                style: AppTextStyle.fontSize13BlackW400,
                              ),
                              5.h.verticalSpacing,

                              /// Driver list dropdown
                              controller.dropdownLoader.value
                                  ? const SecondaryLoadingWidget()
                                  : DuplicateDropdown(
                                      dropdownValue:
                                          controller.initialValue.value,
                                      dropdownList:
                                          controller.adminVehicleDriverList,
                                      changeDropdownValue: (value) {
                                        controller.initialValue.value = value!;
                                        controller.driverId.value = value.id;
                                      },
                                    ),
                              10.h.verticalSpacing,
                              CustomTextFormField(
                                controller: controller.noteTextController,
                                enableBorderActive: true,
                                focusBorderActive: true,
                                hintText: "Note".tr,
                              ),
                              30.h.verticalSpacing,
                              controller.saveLoader.value
                                  ? const SecondaryLoadingWidget(
                                      isBottomNav: true,
                                    )
                                  : PrimaryButton(
                                      text: "Save".tr,
                                      onTap: () {
                                        if (controller.validation()) {
                                          controller.addAdminVehicle();
                                        }
                                      },
                                    ),
                            ],
                          ),
                        ),

                        /// Vehicle List
                        Obx(
                          () => controller.loadingController.isLoading
                              ? const SecondaryLoadingWidget()
                              : controller.adminVehicleList.isNotEmpty
                                  ? RefreshIndicator(
                                      onRefresh: () async {
                                        controller.getAdminVehicleList();
                                      },
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.adminVehicleList.length,
                                        itemBuilder: (context, index) {
                                          return VehicleTile(
                                            model: controller
                                                .adminVehicleList[index]
                                                .vehicleModel,
                                            number: controller
                                                .adminVehicleList[index]
                                                .vehicleNo,
                                            madeYear: controller
                                                .adminVehicleList[index]
                                                .madeYear
                                                .toString(),
                                            note: controller
                                                .adminVehicleList[index].note,
                                            color: index % 2 == 0
                                                ? AppColors.profileCardTextColor
                                                : Colors.white,
                                          );
                                        },
                                      ),
                                    )
                                  : const NoDataAvailableWidget(),
                        ),
                      ],
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
