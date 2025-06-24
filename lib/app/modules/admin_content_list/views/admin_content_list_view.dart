import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_text.dart';
import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../../../utilities/widgets/permission_check/permission_check.dart';
import '../controllers/admin_content_list_controller.dart';
import '../../../utilities/widgets/content_tile.dart';

class AdminContentListView extends GetView<AdminContentListController> {
  const AdminContentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Content List".tr,
      body: CustomBackground(
        customWidget: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            controller.getAdminContentList();
          },
          child: Column(
            children: [
              Obx(
                () => controller.loadingController.isLoading
                    ? const Expanded(
                        child: LoadingWidget(),
                      )
                    : controller.contentList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.contentList.length,
                              itemBuilder: (context, index) {
                                return ContentTile(
                                  title: controller
                                      .contentList[index].contentTitle,
                                  contentType: controller
                                      .contentList[index].contentType?.tr,
                                  date:
                                      controller.contentList[index].uploadDate,
                                  availableFor: controller
                                      .contentList[index].availableFor,
                                  onDeleteTap: () => controller.showDialog(
                                    contentId:
                                        controller.contentList[index].id!,
                                    index: index,
                                  ),
                                  onDownloadTap: () async {
                                    await PermissionCheck()
                                        .checkPermissions(Get.context!);
                                    Get.dialog(
                                      CustomPopupDialogue(
                                        onYesTap: () {
                                          Get.back();

                                          controller.fileDownload(
                                              url: controller.contentList[index]
                                                      .uploadFile ??
                                                  '',
                                              title: controller
                                                      .contentList[index]
                                                      .contentTitle ??
                                                  '');
                                        },
                                        title: 'Confirmation'.tr,
                                        subTitle: AppText.downloadMessage.tr,
                                        noText: 'No'.tr,
                                        yesText: 'Download'.tr,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: NoDataAvailableWidget(),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
