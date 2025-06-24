import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/delete_tile/delete_tile.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/admin_fees_type_controller.dart';

class AdminFeesTypeView extends GetView<AdminFeesTypeController> {
  const AdminFeesTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Fees Type".tr,
        body: CustomBackground(
          customWidget: Column(
            children: [
              controller.getFeesLoader.value
                  ? const Expanded(
                      child: LoadingWidget(),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        color: AppColors.primaryColor,
                        onRefresh: () async {
                          controller.getFeesListList();
                        },
                        child: controller.feesTypeList.isNotEmpty
                            ? ListView.builder(
                                itemCount: controller.feesTypeList.length,
                                itemBuilder: (context, index) {
                                  return DeleteTile(
                                    title:
                                        "${index + 1}. ${controller.feesTypeList[index].name}",
                                    subTitle: controller
                                        .feesTypeList[index].description,

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
                                            controller.deleteSingleFeesType(
                                                feesTypeId: controller
                                                    .feesTypeList[index].id!,
                                                index: index);
                                          },
                                          title: 'Confirmation'.tr,
                                          subTitle:
                                              AppText.deleteFeesTypeWarningMsg,
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
                                      controller.titleTextController.text =
                                          controller.feesTypeList[index].name ??
                                              '';
                                      controller.descriptionTextController
                                          .text = controller.feesTypeList[index]
                                              .description ??
                                          '';
                                      controller.showUploadDocumentsBottomSheet(
                                        header: "Edit".tr,
                                        bottomSheetBackgroundColor:
                                            Colors.white,
                                        titleController:
                                            controller.titleTextController,
                                        descriptionController: controller
                                            .descriptionTextController,
                                        onTapCancel: () {
                                          Get.back();
                                          controller.titleTextController
                                              .clear();
                                          controller.descriptionTextController
                                              .clear();
                                        },
                                        onTapForSave: () {
                                          if (controller.titleTextController
                                              .text.isNotEmpty) {
                                            controller.updateSingleFeesType(
                                                feesGroupId: controller
                                                    .adminFeesGroupController
                                                    .groupId
                                                    .value,
                                                feesTypeId: controller
                                                    .feesTypeList[index].id!,
                                                index: index);
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              )
                            : const NoDataAvailableWidget(),
                      ),
                    ),
              40.verticalSpacing,
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 15,
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            controller.showUploadDocumentsBottomSheet(
              header: "Add Fees Type".tr,
              bottomSheetBackgroundColor: Colors.white,
              titleController: controller.titleTextController,
              descriptionController: controller.descriptionTextController,
              onTapCancel: () {
                Get.back();
                controller.titleTextController.clear();
                controller.descriptionTextController.clear();
              },
              onTapForSave: () {
                if (controller.titleTextController.text.isEmpty) {
                  showBasicFailedSnackBar(message: "Add title".tr);
                } else {
                  controller.createFeesType(
                      feesGroupId:
                          controller.adminFeesGroupController.groupId.value);
                }
              },
            );
          },
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
