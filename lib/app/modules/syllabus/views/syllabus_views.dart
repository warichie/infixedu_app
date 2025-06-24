import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/modules/syllabus/views/widgets/syllabus_topic_wise.dart';
import 'package:infixedu/app/utilities/file_downloader/file_download_utils.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';

import '../../../utilities/message/snack_bars.dart';
import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../../../utilities/widgets/permission_check/permission_check.dart';
import '../controller/syllabus_controller.dart';

class SyllabusView extends GetView<SyllabusController> {
  const SyllabusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Syllabus".tr,
        body: CustomBackground(
          customWidget: controller.loadingController.isLoading
              ? const LoadingWidget()
              : controller.syllabusList.isNotEmpty
                  ? RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: () async {
                        controller.syllabusList.clear();
                        controller.getSyllabusList();
                      },
                      child: ListView.builder(
                        itemCount: controller.syllabusList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, int index) => SyllabusTopicWise(
                          contentTitle:
                              controller.syllabusList[index].contentTitle ?? '',
                          topic:
                              controller.syllabusList[index].description ?? '',
                          date: controller.syllabusList[index].uploadDate ?? '',
                          onTap: () {
                            PermissionCheck().checkPermissions(context);
                            Get.dialog(
                              CustomPopupDialogue(
                                onYesTap: () {
                                  Navigator.pop(context);
                                  controller.syllabusList[index].uploadFile!
                                          .isNotEmpty
                                      ? FileDownloadUtils().downloadFiles(
                                          url: controller
                                              .syllabusList[index].uploadFile!,
                                          title: controller.syllabusList[index]
                                              .contentTitle!)
                                      : showBasicFailedSnackBar(
                                          message: 'No File Available'.tr);
                                },
                                title: 'Confirmation'.tr,
                                subTitle: AppText.downloadMessage.tr,
                                noText: 'No'.tr,
                                yesText: 'Download'.tr,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const NoDataAvailableWidget(),
        ),
      ),
    );
  }
}
