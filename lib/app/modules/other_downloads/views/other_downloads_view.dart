import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/modules/other_downloads/views/widget/other_downloads_tile.dart';
import 'package:infixedu/app/utilities/file_downloader/file_download_utils.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/permission_check/permission_check.dart';
import 'package:get/get.dart';
import '../../../utilities/widgets/loader/loading.widget.dart';
import '../../../utilities/widgets/no_data_available/no_data_available_widget.dart';
import '../controllers/other_downloads_controller.dart';

class OtherDownloadsView extends GetView<OtherDownloadsController> {
  const OtherDownloadsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Other Downloads".tr,
        body: CustomBackground(
          customWidget: controller.loadingController.isLoading
              ? const LoadingWidget()
              : controller.studentOthersDownloadList.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        controller.studentOthersDownloadList.clear();
                        controller.getStudentOthersDownloadList();
                      },
                      child: ListView.builder(
                        itemCount: controller.studentOthersDownloadList.length,
                        itemBuilder: (context, int index) {
                          return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: OtherDownloadsTile(
                                contentTitle: controller
                                    .studentOthersDownloadList[index]
                                    .contentTitle,
                                topic: controller
                                    .studentOthersDownloadList[index]
                                    .availableFor,
                                date: controller
                                        .studentOthersDownloadList[index]
                                        .uploadDate ??
                                    '',
                                description: controller
                                        .studentOthersDownloadList[index]
                                        .description ??
                                    '',
                                onTap: () async {
                                  await PermissionCheck()
                                      .checkPermissions(context);
                                  Get.dialog(
                                    CustomPopupDialogue(
                                      onYesTap: () {
                                        Navigator.pop(context);
                                        controller
                                                .studentOthersDownloadList[
                                                    index]
                                                .uploadFile!
                                                .isNotEmpty
                                            ? FileDownloadUtils().downloadFiles(
                                                url: controller
                                                    .studentOthersDownloadList[
                                                        index]
                                                    .uploadFile!,
                                                title: controller
                                                    .studentOthersDownloadList[
                                                        index]
                                                    .contentTitle!)
                                            : showBasicFailedSnackBar(
                                                message:
                                                    'No File Available'.tr);
                                      },
                                      title: 'Confirmation'.tr,
                                      subTitle: AppText.downloadMessage.tr,
                                      noText: 'No'.tr,
                                      yesText: 'Download'.tr,
                                    ),
                                  );
                                },
                              ));
                        },
                      ),
                    )
                  : const NoDataAvailableWidget(),
        ),
      ),
    );
  }
}
