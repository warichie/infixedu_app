import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/delete_tile/delete_tile.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/admin_route_controller.dart';

class AdminRouteView extends GetView<AdminRouteController> {
  const AdminRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: InfixEduScaffold(
        title: "Route".tr,
        body: CustomBackground(
          customWidget: Column(
            children: [
              10.h.verticalSpacing,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: TabBar(
                  labelColor: AppColors.profileValueColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: AppTextStyle.fontSize12LightGreyW500,
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
              10.h.verticalSpacing,
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0.w, vertical: 10.w),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomTextFormField(
                              controller: controller.routeTitleTextController,
                              enableBorderActive: true,
                              focusBorderActive: true,
                              hintText: "${"Route Title".tr} *",
                              fillColor: Colors.white,
                            ),
                            10.h.verticalSpacing,
                            CustomTextFormField(
                              inputFormatter: [
                                FilteringTextInputFormatter.deny('-')
                              ],
                              controller: controller.routeFareTextController,
                              textInputType: TextInputType.number,
                              enableBorderActive: true,
                              focusBorderActive: true,
                              hintText: "${"Route fare".tr} *",
                              fillColor: Colors.white,
                            ),
                            30.h.verticalSpacing,
                            Obx(() => controller.saveLoader.value
                                ? const SecondaryLoadingWidget()
                                : PrimaryButton(
                                    text: "Save".tr,
                                    onTap: () {
                                      if (controller.validation()) {
                                        controller.addTransportRoute();
                                      }
                                    },
                                  ))
                          ],
                        ),
                      ),
                    ),

                    /// Route List
                    Obx(
                      () => controller.loadingController.isLoading
                          ? const SecondaryLoadingWidget()
                          : controller.adminTransportRouteList.isNotEmpty
                              ? RefreshIndicator(
                                  color: AppColors.primaryColor,
                                  onRefresh: () async {
                                    controller.adminTransportRouteList.clear();
                                    controller.getAdminTransportRouteList();
                                  },
                                  child: ListView.builder(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    itemCount: controller
                                        .adminTransportRouteList.length,
                                    itemBuilder: (context, index) {
                                      return DeleteTile(
                                        title:
                                            "${index + 1}. ${controller.adminTransportRouteList[index].title}",
                                        subTitle:
                                            "${"Fare".tr}: ${controller.adminTransportRouteList[index].fare.toString()}",

                                        /// Delete button
                                        rightIconBackgroundColor:
                                            const Color(0xFFED3B3B),
                                        rightIcon: Iconsax.trash,
                                        tapRightButton: () => Get.dialog(
                                          Obx(
                                            () => CustomPopupDialogue(
                                              isLoading:
                                                  controller.deleteLoader.value,
                                              onYesTap: () {
                                                controller.deleteSingleRoute(
                                                    routeId: controller
                                                        .adminTransportRouteList[
                                                            index]
                                                        .id!,
                                                    index: index);
                                              },
                                              title: 'Confirmation'.tr,
                                              subTitle: AppText
                                                  .deleteFeesGroupWarningMsg.tr,
                                              noText: 'Cancel'.tr,
                                              yesText: 'Delete'.tr,
                                            ),
                                          ),
                                        ),

                                        /// Edit button
                                        leftIcon: Iconsax.edit_2,
                                        leftIconBackgroundColor:
                                            AppColors.appButtonColor,
                                        tapLeftButton: () {
                                          controller.routeTitleTextController
                                              .text = controller
                                                  .adminTransportRouteList[
                                                      index]
                                                  .title ??
                                              '';
                                          controller.routeFareTextController
                                                  .text =
                                              controller
                                                  .adminTransportRouteList[
                                                      index]
                                                  .fare
                                                  .toString();
                                          controller
                                              .showUploadDocumentsBottomSheet(
                                            routeId: controller
                                                .adminTransportRouteList[index]
                                                .id!,
                                            index: index,
                                            bottomSheetBackgroundColor:
                                                Colors.white,
                                            header: "Edit Route".tr,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                )
                              : const NoDataAvailableWidget(),
                    ),
                  ],
                ),
              ),
              50.h.verticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
