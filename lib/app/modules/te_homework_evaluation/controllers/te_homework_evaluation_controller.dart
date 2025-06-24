import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/file_downloader/file_download_utils.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/appbar/back_button_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/study_button/study_button.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:infixedu/domain/core/model/teacher/teacher_homework_model/te_homework_evaluation_list_response_model.dart';
import 'package:get/get.dart';

class TeHomeworkEvaluationController extends GetxController {
  TextEditingController addMarksController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxInt clasId = 0.obs;
  RxString clasName = "".obs;
  RxString sectionName = "".obs;
  RxString commentStatus = "G".obs;
  RxString homeworkStatus = "C".obs;
  RxBool submitEvaluationLoader = false.obs;
  RxInt sectionId = 0.obs;
  RxInt homeworkId = 0.obs;
  RxInt studentId = 0.obs;
  final subjectName = Rxn<String>();
  final assignDate = Rxn<String>();
  final submissionDate = Rxn<String>();
  final evaluation = Rxn<String>();
  final file = Rxn<String>();
  final marks = Rxn<int>();
  final selectIndex = RxInt(0);
  final selectIndexForHomework = RxInt(0);

  List<String> commentStatusList = ["Good", "Not Good"];
  List<String> homeworkStatusList = ["Completed", "Not Completed"];

  RxList<HomeworkList> homeworkEvaluationList = <HomeworkList>[].obs;

  RxBool isLoading = false.obs;

  Future<TeHomeworkEvaluationListResponseModel> getHomeworkEvaluationList(
      String searchKey) async {
    try {
      homeworkEvaluationList.clear();
      isLoading.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getTeacherHomeworkEvaluationList(
          classId: clasId.value,
          sectionId: sectionId.value,
          homeworkId: homeworkId.value,
          searchKey: searchKey,
        ),
        header: GlobalVariable.header,
      );

      TeHomeworkEvaluationListResponseModel
          teHomeworkEvaluationListResponseModel =
          TeHomeworkEvaluationListResponseModel.fromJson(response);

      if (teHomeworkEvaluationListResponseModel.success == true) {
        isLoading.value = false;
        if (teHomeworkEvaluationListResponseModel.data!.isNotEmpty) {
          for (var element in teHomeworkEvaluationListResponseModel.data!) {
            homeworkEvaluationList.add(element);
          }
        }
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(
            message: teHomeworkEvaluationListResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }

    return TeHomeworkEvaluationListResponseModel();
  }

  void evaluateStudent({required int index, required int studentId}) {
    Get.dialog(
      Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.h.verticalSpacing,
                  Row(
                    children: [
                      BackButtonWidget(
                        color: Colors.black,
                      ),
                      20.w.horizontalSpacing,
                      Text(
                        "Evaluate".tr,
                        style: AppTextStyle.fontSize13BlackW400,
                      ),
                    ],
                  ),
                  30.h.verticalSpacing,
                  CustomTextFormField(
                    controller: addMarksController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Add Marks".tr} *",
                    fillColor: Colors.white,
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                  ),
                  20.h.verticalSpacing,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Comment".tr,
                      style: AppTextStyle.fontSize13BlackW400,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: commentStatusList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Obx(
                            () => StudyButton(
                              title: commentStatusList[index].tr,
                              onItemTap: () {
                                selectIndex.value = index;
                                selectIndex.value == 0
                                    ? commentStatus.value == "G"
                                    : commentStatus.value = "NG";
                              },
                              isSelected: selectIndex.value == index,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  20.h.verticalSpacing,
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Homework Status".tr,
                      style: AppTextStyle.fontSize13BlackW400,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeworkStatusList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Obx(
                            () => StudyButton(
                              title: homeworkStatusList[index].tr,
                              onItemTap: () {
                                selectIndexForHomework.value = index;
                                selectIndex.value == 0
                                    ? homeworkStatus.value == "C"
                                    : homeworkStatus.value = "NC";
                              },
                              isSelected: selectIndexForHomework.value == index,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  50.h.verticalSpacing,
                  submitEvaluationLoader.value
                      ? const SecondaryLoadingWidget()
                      : PrimaryButton(
                          text: "Evaluate".tr,
                          onTap: () {
                            if (addMarksController.text.isNotEmpty) {
                              submitEvaluation(
                                studentId: studentId,
                                homeworkStatus: homeworkStatus.value,
                                commentStatus: commentStatus.value,
                                index: index,
                              );
                            } else {
                              showBasicFailedSnackBar(message: "Add Marks".tr);
                            }
                          },
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitEvaluation({
    required int studentId,
    required String commentStatus,
    required String homeworkStatus,
    required int index,
  }) async {
    try {
      if ((marks.value?.toDouble() ?? 0.0) <
          double.parse(addMarksController.text)) {
        showBasicFailedSnackBar(
            message: "${"Maximum Evaluation can be".tr}: ${marks.value}");
        return;
      }

      submitEvaluationLoader.value = true;
      final response = await BaseClient().postData(
        url: InfixApi.submitEvaluation,
        header: GlobalVariable.header,
        payload: {
          "student_id": studentId,
          "homework_id": homeworkId.value,
          "marks": addMarksController.text,
          "homework_status": homeworkStatus,
          "teacher_comments": commentStatus,
        },
      );
      addMarksController.clear();

      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        homeworkEvaluationList[index].evaluated = true;
        homeworkEvaluationList.refresh();
        submitEvaluationLoader.value = false;
        Get.back();
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? "Successful".tr);
      } else {
        submitEvaluationLoader.value = false;
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      submitEvaluationLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      submitEvaluationLoader.value = false;
    }
  }

  void downloadFile({required String url, required String title}) {
    if (url.isEmpty) {
      showBasicFailedSnackBar(message: "Something went wrong".tr);
      return;
    }
    FileDownloadUtils().downloadFiles(url: url, title: title);
  }

  void _receiveDataFromTeacherHomeworkListView() {
    clasId.value = Get.arguments['class_id'];
    sectionId.value = Get.arguments['section_id'];
    homeworkId.value = Get.arguments['homework_id'];
    subjectName.value = Get.arguments['subject_name'];
    assignDate.value = Get.arguments['assign_date'];
    submissionDate.value = Get.arguments['submission_date'];
    evaluation.value = Get.arguments['evaluation'];
    marks.value = Get.arguments['marks'];
    file.value = Get.arguments['file'];
    clasName.value = Get.arguments['class_name'];
    sectionName.value = Get.arguments['section_name'] ?? "";
  }

  @override
  void onInit() {
    _receiveDataFromTeacherHomeworkListView();
    getHomeworkEvaluationList("");

    super.onInit();
  }
}
