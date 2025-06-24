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

import '../controllers/admin_fees_group_controller.dart';

class AdminFeesGroupView extends GetView<AdminFeesGroupController> {
  const AdminFeesGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Fees Group".tr,
        body: CustomBackground(
          customWidget: Column(
            children: [
              controller.loadingController.isLoading
                  ? const Expanded(
                      child: LoadingWidget(),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        color: AppColors.primaryColor,
                        onRefresh: () async {
                          controller.feesGroupList.clear();
                          controller.getFeesGroupList();
                        },
                        child: controller.feesGroupList.isNotEmpty
                            ? ListView.builder(
                                itemCount: controller.feesGroupList.length,
                                itemBuilder: (context, index) {
                                  return DeleteTile(
                                    title:
                                        "${index + 1}. ${controller.feesGroupList[index].name}",
                                    subTitle: controller
                                        .feesGroupList[index].description,

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
                                            controller.deleteSingleFees(
                                                feesId: controller
                                                    .feesGroupList[index].id!,
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
                                      controller.titleTextController.text =
                                          controller
                                                  .feesGroupList[index].name ??
                                              '';
                                      controller.descriptionTextController
                                          .text = controller
                                              .feesGroupList[index]
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
                                            controller.updateSingleFeesGroup(
                                                feesId: controller
                                                    .feesGroupList[index].id!,
                                                index: index);
                                            controller.titleTextController
                                                .clear();
                                            controller.descriptionTextController
                                                .clear();
                                          } else {
                                            showBasicFailedSnackBar(
                                                message:
                                                    'Title is required'.tr);
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
              header: "Add Fees Group".tr,
              bottomSheetBackgroundColor: Colors.white,
              titleController: controller.titleTextController,
              descriptionController: controller.descriptionTextController,
              onTapCancel: () {
                Get.back();
                controller.titleTextController.clear();
                controller.descriptionTextController.clear();
              },
              onTapForSave: () {
                if (controller.titleTextController.text.isEmpty ||
                    controller.descriptionTextController.text.isEmpty) {
                  showBasicFailedSnackBar(
                      message: 'All fields are required'.tr);
                } else {
                  controller.createFeesGroup();
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
