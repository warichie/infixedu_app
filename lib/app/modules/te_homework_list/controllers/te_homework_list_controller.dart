import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/modules/te_add_homework/controllers/te_add_homework_controller.dart';
import 'package:infixedu/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/file_downloader/file_download_utils.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/teacher/teacher_homework_model/teacher_homework_list_response_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../../../utilities/widgets/permission_check/permission_check.dart';

class TeHomeworkListController extends GetxController {
  TeAddHomeworkController teAddHomeworkController =
      Get.put(TeAddHomeworkController());

  TextEditingController searchController = TextEditingController();

  RxBool isTapped = false.obs;
  RxBool isDropDownChanged = false.obs;
  RxBool isLoading = false.obs;
  RxBool searchHomeworkLoader = false.obs;
  RxBool homeworkLoader = false.obs;

  RxList<TeacherHomeworkData> teacherHomeworkList = <TeacherHomeworkData>[].obs;

  Future<TeacherHomeworkListResponseModel> getTeacherHomeWorkList() async {
    try {
      teacherHomeworkList.clear();
      homeworkLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getTeacherHomeworkList,
        header: GlobalVariable.header,
      );

      TeacherHomeworkListResponseModel teacherHomeworkListResponseModel =
          TeacherHomeworkListResponseModel.fromJson(response);

      if (teacherHomeworkListResponseModel.success == true) {
        homeworkLoader.value = false;
        if (teacherHomeworkListResponseModel.data!.isNotEmpty) {
          for (var element in teacherHomeworkListResponseModel.data!) {
            teacherHomeworkList.add(element);
          }
        }
      } else {
        homeworkLoader.value = false;
        showBasicFailedSnackBar(
            message: teacherHomeworkListResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      homeworkLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      homeworkLoader.value = false;
    }

    return TeacherHomeworkListResponseModel();
  }

  Future<TeacherHomeworkListResponseModel?> filterHomework({
    required int classId,
    int? subjectId,
    int? sectionId,
  }) async {
    try {
      searchHomeworkLoader.value = true;

      String baseUrl = InfixApi.getTeacherHomeworkSearch(
        classId: classId,
        subjectId: subjectId,
      );

      if (sectionId != null && sectionId >= 0 && sectionId != -1) {
        baseUrl += '&sectionId=$sectionId';
      }

      final response = await BaseClient().getData(
        url: baseUrl,
        header: GlobalVariable.header,
      );

      TeacherHomeworkListResponseModel teacherHomeworkListResponseModel =
          TeacherHomeworkListResponseModel.fromJson(response);

      if (teacherHomeworkListResponseModel.success == true) {
        teacherHomeworkList.clear();
        searchHomeworkLoader.value = false;
        if (teacherHomeworkListResponseModel.data!.isNotEmpty) {
          for (var element in teacherHomeworkListResponseModel.data!) {
            teacherHomeworkList.add(element);
          }
        }
      } else {
        searchHomeworkLoader.value = false;
        showBasicFailedSnackBar(
            message: teacherHomeworkListResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      searchHomeworkLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      searchHomeworkLoader.value = false;
    }
    return TeacherHomeworkListResponseModel();
  }

  void showHomeworkDetailsBottomSheet(
      {required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.55,
        color: bottomSheetBackgroundColor,
        child: teacherHomeworkList.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.h.verticalSpacing,
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        teacherHomeworkList[index].subjectName ?? "",
                        style: AppTextStyle.fontSize14BlackW500,
                      ),
                    ),
                    BottomSheetTile(
                      title: "Assign Date".tr,
                      value: teacherHomeworkList[index].assignDate,
                      color: AppColors.homeworkWidgetColor,
                    ),
                    BottomSheetTile(
                      title: "Submission Date".tr,
                      value: teacherHomeworkList[index].submissionDate,
                      color: Colors.white,
                    ),
                    BottomSheetTile(
                      title: "Marks".tr,
                      value: teacherHomeworkList[index].marks.toString(),
                      color: AppColors.homeworkWidgetColor,
                    ),
                    BottomSheetTile(
                      title: "Evaluation".tr,
                      value: teacherHomeworkList[index].evaluation ?? "",
                      color: Colors.white,
                    ),
                    Container(
                      height: Get.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.homeworkWidgetColor,
                        ),
                        color: AppColors.homeworkWidgetColor,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: Get.width * 0.41,
                            child: Text(
                              "Documents".tr,
                              style: AppTextStyle.fontSize12lightViolateW400,
                            ),
                          ),
                          VerticalDivider(
                            color: AppColors.bottomSheetDividerColor,
                            thickness: 1,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: InkWell(
                              onTap: () async {
                                await PermissionCheck()
                                    .checkPermissions(Get.context!);
                                Get.dialog(
                                  CustomPopupDialogue(
                                    onYesTap: () {
                                      Get.back();

                                      if (teacherHomeworkList[index].file ==
                                              null ||
                                          (teacherHomeworkList[index].file ??
                                                  "")
                                              .isEmpty) {
                                        showBasicFailedSnackBar(
                                            message: "No File Available".tr);
                                      }
                                      downloadFile(
                                          url:
                                              teacherHomeworkList[index].file ??
                                                  "",
                                          title: teacherHomeworkList[index]
                                                  .subjectName ??
                                              "");
                                    },
                                    title: 'Confirmation'.tr,
                                    subTitle: AppText.downloadMessage.tr,
                                    noText: 'No'.tr,
                                    yesText: 'Download'.tr,
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.download,
                                    size: 15.h,
                                    color: Color(0xFF3490DC),
                                  ),
                                  5.horizontalSpacing,
                                  Text(
                                    "Download".tr,
                                    style: TextStyle(
                                      color: Color(0xFF3490DC),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Text(
                  "No Details Available".tr,
                  style: AppTextStyle.fontSize16lightBlackW500,
                ),
              ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }

  void downloadFile({required String url, required String title}) {
    FileDownloadUtils().downloadFiles(url: url, title: title);
  }

  @override
  void onInit() {
    getTeacherHomeWorkList();
    super.onInit();
  }
}
