import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/utilities/widgets/content_tile/content_tile.dart';
import 'package:infixedu/app/utilities/file_downloader/file_download_utils.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:infixedu/app/utilities/widgets/permission_check/permission_check.dart';

import 'package:get/get.dart';

import '../controllers/assignment_controller.dart';

class AssignmentView extends GetView<AssignmentController> {
  const AssignmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Assignment".tr,
        body: RefreshIndicator(
          onRefresh: () async {
            controller.studentAssignmentList.clear();
            controller.getStudentAssignmentList();
          },
          child: CustomBackground(
            customWidget: controller.loadingController.isLoading
                ? const LoadingWidget()
                : controller.studentAssignmentList.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.all(10.0.w),
                        child: ListView.builder(
                          itemCount: controller.studentAssignmentList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.0.h),
                              child: ContentTile(
                                title: controller
                                    .studentAssignmentList[index].contentTitle,
                                details:
                                    "${"assigned to".tr} ${controller.studentAssignmentList[index].availableFor}",
                                dueDate: controller
                                    .studentAssignmentList[index].uploadDate,
                                description: controller
                                    .studentAssignmentList[index].description,
                                cardBackgroundColor: Colors.white,
                                onTap: () {
                                  PermissionCheck().checkPermissions(context);
                                  Get.dialog(
                                    CustomPopupDialogue(
                                      onYesTap: () {
                                        Navigator.pop(context);
                                        controller.studentAssignmentList[index]
                                                .uploadFile!.isNotEmpty
                                            ? FileDownloadUtils().downloadFiles(
                                                url: controller
                                                    .studentAssignmentList[
                                                        index]
                                                    .uploadFile!,
                                                title: controller
                                                    .studentAssignmentList[
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
                              ),
                            );
                          },
                        ),
                      )
                    : const NoDataAvailableWidget(),
          ),
        ),
      ),
    );
  }
}
