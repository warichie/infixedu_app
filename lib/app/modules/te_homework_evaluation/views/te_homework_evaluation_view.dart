import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/modules/book_list/views/widget/search_field.dart';
import 'package:infixedu/app/modules/te_homework_list/views/widget/homework_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';

import 'package:get/get.dart';

import '../../../data/constants/app_text.dart';
import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../../../utilities/widgets/permission_check/permission_check.dart';
import '../controllers/te_homework_evaluation_controller.dart';

class TeHomeworkEvaluationView extends GetView<TeHomeworkEvaluationController> {
  const TeHomeworkEvaluationView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Homework evaluation".tr,
      body: CustomBackground(
        customWidget: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 15,
                ),
                child: SearchField(
                  borderRadius: 2,
                  controller: controller.searchController,
                  onChange: (searchKey) {
                    if (searchKey.isEmpty) {
                      controller.getHomeworkEvaluationList('');
                    }
                    if (controller.isLoading.value) {
                      return;
                    }
                    controller.getHomeworkEvaluationList(searchKey);
                  },
                  hintTextStyle: AppTextStyle.fontSize12GreyW400,
                  icon: controller.searchController.text.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            controller.searchController.clear();
                            controller.homeworkEvaluationList.clear();
                            controller.getHomeworkEvaluationList("");
                          },
                          child: Icon(
                            Icons.close,
                            color: AppColors.profileDividerColor,
                            size: 20.h,
                          ),
                        )
                      : Icon(
                          Icons.search,
                          color: AppColors.profileDividerColor,
                          size: 20.h,
                        ),
                ),
              ),
              5.h.verticalSpacing,
              Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.w),
                    topLeft: Radius.circular(8.w),
                  ),
                  color: AppColors.profileCardBackgroundColor,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.23,
                      child: Text(
                        "Admission No".tr,
                        style: AppTextStyle.textStyle10WhiteW400,
                      ),
                    ),
                    const VerticalDivider(
                      color: AppColors.profileTitleColor,
                      thickness: 1,
                    ),
                    SizedBox(
                      width: Get.width * 0.28,
                      child: Text(
                        "Student Name".tr,
                        style: AppTextStyle.textStyle10WhiteW400,
                      ),
                    ),
                    const VerticalDivider(
                      color: AppColors.profileTitleColor,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              controller.isLoading.value
                  ? const SecondaryLoadingWidget()
                  : Expanded(
                      child: controller.homeworkEvaluationList.isNotEmpty
                          ? ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              itemCount:
                                  controller.homeworkEvaluationList.length,
                              itemBuilder: (context, index) {
                                return HomeworkTile(
                                  widthOfFirstContainer: Get.width * 0.23,
                                  widthOfSecondContainer: Get.width * 0.28,
                                  onDownloadTap: () async {
                                    await PermissionCheck()
                                        .checkPermissions(Get.context!);
                                    Get.dialog(
                                      CustomPopupDialogue(
                                        onYesTap: () {
                                          Get.back();

                                          if ((controller
                                                      .homeworkEvaluationList[
                                                          index]
                                                      .homeworkFiles ??
                                                  [])
                                              .isEmpty) {
                                            showBasicFailedSnackBar(
                                                message:
                                                    "No file available on server"
                                                        .tr);
                                            return;
                                          }

                                          controller.downloadFile(
                                              url: controller
                                                      .homeworkEvaluationList[
                                                          index]
                                                      .homeworkFiles
                                                      ?.last ??
                                                  "",
                                              title: controller
                                                      .homeworkEvaluationList[
                                                          index]
                                                      .homeworkFiles!
                                                      .last ??
                                                  "");
                                        },
                                        title: 'Confirmation'.tr,
                                        subTitle: AppText.downloadMessage.tr,
                                        noText: 'No'.tr,
                                        yesText: 'Download'.tr,
                                      ),
                                    );
                                  },
                                  studentName: controller
                                      .homeworkEvaluationList[index]
                                      .studentName,
                                  admissionNo: controller
                                      .homeworkEvaluationList[index].admissionNo
                                      .toString(),
                                  downloadContainerColor: controller
                                          .homeworkEvaluationList[index]
                                          .homeworkFiles!
                                          .isEmpty
                                      ? AppColors.transportDividerColor
                                      : AppColors.syllabusTextColorBlack,
                                  evaluateContainerColor: controller
                                          .homeworkEvaluationList[index]
                                          .evaluated!
                                      ? AppColors.appButtonColor
                                      : AppColors.activeStatusGreenColor,
                                  onEvaluationTap: () {
                                    controller.evaluateStudent(
                                        index: index,
                                        studentId: controller
                                            .homeworkEvaluationList[index]
                                            .studentId!);
                                  },
                                  isEvaluation: true,
                                );
                              })
                          : const SingleChildScrollView(
                              child: Center(child: NoDataAvailableWidget())),
                    ),
              10.h.verticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
