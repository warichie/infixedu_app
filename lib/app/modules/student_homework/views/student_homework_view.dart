import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/modules/student_homework/views/widgets/homework_card_tile.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text.dart';
import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../../../utilities/widgets/permission_check/permission_check.dart';
import '../controllers/student_homework_controller.dart';

class StudentHomeworkView extends GetView<StudentHomeworkController> {
  const StudentHomeworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
          title: "Homework".tr,
          body: RefreshIndicator(
            onRefresh: () async {
              controller.studentHomeworkList.clear();
              controller.getHomeWorkList();
            },
            child: CustomBackground(
              customWidget: controller.loadingController.isLoading
                  ? const LoadingWidget()
                  : controller.studentHomeworkList.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.studentHomeworkList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var data = controller.studentHomeworkList[index];
                            // String createdAt = DateTimeConverter()
                            //     .convertISOToDesiredFormat(
                            //         data.createdAt ?? '');
                            return Padding(
                              padding: EdgeInsets.only(top: 10.0.h),
                              child: HomeworkCardTile(
                                subject: data.subject,
                                created: data.createdAt,
                                submission: data.submissionDate,
                                evaluation: data.evaluationDate,
                                status: data.status,
                                marks: data.marks.toString(),
                                statusColor: data.status == 'Completed'
                                    ? AppColors.homeworkStatusGreenColor
                                    : AppColors.homeworkStatusRedColor,
                                backgroundColor: index % 2 == 0
                                    ? Colors.white
                                    : AppColors.homeworkWidgetColor,
                                onTap: () {
                                  controller.showHomeworkDetailsBottomSheet(
                                    index: index,
                                    color: Colors.white,
                                    onDownloadTap: () async {
                                      await PermissionCheck()
                                          .checkPermissions(Get.context!);
                                      Get.dialog(
                                        CustomPopupDialogue(
                                          onYesTap: () {
                                            Get.back();
                                            if (controller
                                                        .studentHomeworkList[
                                                            index]
                                                        .file ==
                                                    null ||
                                                controller
                                                        .studentHomeworkList[
                                                            index]
                                                        .file ==
                                                    '') {
                                              showBasicFailedSnackBar(
                                                  message:
                                                      'No file available on server'
                                                          .tr);
                                            } else {
                                              controller.downloadFile(
                                                  url: controller
                                                      .studentHomeworkList[
                                                          index]
                                                      .file!,
                                                  title: controller
                                                          .studentHomeworkList[
                                                              index]
                                                          .subject ??
                                                      '');
                                            }
                                          },
                                          title: 'Confirmation'.tr,
                                          subTitle: AppText.downloadMessage.tr,
                                          noText: 'No'.tr,
                                          yesText: 'Download'.tr,
                                        ),
                                      );
                                    },
                                    onUploadTap: () =>
                                        controller.isUpload.value = true,
                                    onTapBrowse: () => controller.pickFile(),
                                    onTapForSave: () {
                                      controller.uploadFilesWithId(
                                          controller.pickedFileList,
                                          controller
                                              .studentHomeworkList[index].id!);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        )
                      : const NoDataAvailableWidget(),
            ),
          ),
        ));
  }
}
