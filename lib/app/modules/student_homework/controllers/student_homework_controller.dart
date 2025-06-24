import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/file_downloader/file_download_utils.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_browse_icon.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/student_homework_response_model/student_homework_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import '../../../utilities/widgets/button/primary_button.dart';

class StudentHomeworkController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  List<HomeworkLists> studentHomeworkList = [];
  LoadingController loadingController = Get.find();
  TextEditingController uploadFileTextController = TextEditingController();
  RxBool saveLoader = false.obs;

  RxList<File> pickedFileList = <File>[].obs;

  RxBool isUpload = false.obs;
  RxBool isDismissible = true.obs;

  void getHomeWorkList() async {
    try {
      loadingController.isLoading = true;
      final response = await BaseClient().getData(
          url: InfixApi.getStudentHomeWork(
            globalRxVariableController.studentRecordId.value!,
          ),
          header: GlobalVariable.header);

      StudentHomeWorkModel studentHomeWorkModel =
          StudentHomeWorkModel.fromJson(response);

      if (studentHomeWorkModel.success == true) {
        loadingController.isLoading = false;
        if (studentHomeWorkModel.data!.homeworkLists!.isNotEmpty) {
          for (int i = 0;
              i < studentHomeWorkModel.data!.homeworkLists!.length;
              i++) {
            studentHomeworkList
                .add(studentHomeWorkModel.data!.homeworkLists![i]);
          }
        }
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }

  void showHomeworkDetailsBottomSheet({
    required int index,
    Color? color,
    Function()? onDownloadTap,
    Function()? onUploadTap,
    Function()? onTapForSave,
    Function()? onTapBrowse,
  }) {
    Get.bottomSheet(
      Obx(
        () => Container(
          color: color,
          height: Get.height * 0.4,
          child: studentHomeworkList.isNotEmpty
              ? isUpload.value
                  ? Column(
                      children: [
                        Container(
                          height: Get.height * 0.1,
                          width: Get.width,
                          padding: EdgeInsets.all(20),
                          color: AppColors.primaryColor,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Upload Homework".tr,
                                style: AppTextStyle.cardTextStyle14WhiteW500,
                              ),
                              InkWell(
                                onTap: () {
                                  debugPrint('Canceled');
                                  isUpload.value = false;
                                  Get.back();
                                },
                                child: Container(
                                  height: 20.w,
                                  width: 20.w,
                                  // padding:  EdgeInsets.all(5.w),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.close,
                                    size: 14.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.h.verticalSpacing,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: CustomTextFormField(
                            enableBorderActive: true,
                            focusBorderActive: true,
                            fillColor: Colors.white,
                            hintText: pickedFileList.isNotEmpty
                                ? pickedFileList.first.path.split('/').last
                                : 'Select File'.tr,
                            readOnly: true,
                            suffixIcon: const CustomBrowseIcon(),
                            iconOnTap: onTapBrowse,
                          ),
                        ),
                        Obx(() => pickedFileList.isEmpty
                            ? const SizedBox()
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: pickedFileList.length,
                                itemBuilder: (itemBuilder, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            pickedFileList[index]
                                                .path
                                                .split('/')
                                                .last,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            pickedFileList.removeAt(index);
                                            pickedFileList.refresh();
                                          },
                                          child: Icon(Icons.cancel_outlined,
                                              size: 16.w),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SecondaryButton(
                                width: (Get.width * 0.15),
                                title: "Cancel".tr,
                                color: Colors.white,
                                textStyle: AppTextStyle.fontSize13BlackW400,
                                borderColor: AppColors.primaryColor,
                                onTap: () {
                                  debugPrint('Canceled');
                                  isUpload.value = false;
                                  Navigator.pop(Get.context!);
                                },
                              ),
                              Obx(
                                () => saveLoader.value == true
                                    ? const CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      )
                                    : SecondaryButton(
                                        width: (Get.width * 0.2),
                                        title: "Save".tr,
                                        textStyle:
                                            AppTextStyle.textStyle12WhiteW500,
                                        onTap: onTapForSave,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.h.verticalSpacing,
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  studentHomeworkList[index].subject ?? "",
                                  style: AppTextStyle.fontSize14BlackW500,
                                ),
                              ),
                              BottomSheetTile(
                                title: "Created at".tr,
                                value: studentHomeworkList[index].createdAt,
                                color: AppColors.homeworkWidgetColor,
                              ),
                              BottomSheetTile(
                                title: "Submission".tr,
                                value:
                                    studentHomeworkList[index].submissionDate,
                                color: Colors.white,
                              ),
                              BottomSheetTile(
                                title: "Evaluation".tr,
                                value:
                                    studentHomeworkList[index].evaluationDate,
                                color: AppColors.homeworkWidgetColor,
                              ),
                              BottomSheetTile(
                                title: "Obtained Marks".tr,
                                value:
                                    studentHomeworkList[index].obtainedMarks ??
                                        '',
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: onDownloadTap,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.appButtonColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImagePath.download,
                                          scale: 4,
                                          color: Colors.white,
                                          height: 16.w,
                                          width: 16.w,
                                        ),
                                        5.w.horizontalSpacing,
                                        Text(
                                          "Download".tr,
                                          style: AppTextStyle
                                              .cardTextStyle14WhiteW500,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: onUploadTap,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.appButtonColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Transform.flip(
                                          flipY: true,
                                          child: Image.asset(
                                            ImagePath.download,
                                            scale: 4,
                                            color: Colors.white,
                                            height: 16.w,
                                            width: 16.w,
                                          ),
                                        ),
                                        5.w.horizontalSpacing,
                                        Text(
                                          "Upload".tr,
                                          style: AppTextStyle
                                              .cardTextStyle14WhiteW500,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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
      ),
      shape: defaultBottomSheetShape(),
    );
  }

  void downloadFile({required String url, required String title}) {
    FileDownloadUtils().downloadFiles(url: url, title: title);
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      pickedFileList.value = result.paths.map((path) => File(path!)).toList();
      pickedFileList.refresh();
    } else {
      showBasicFailedSnackBar(message: 'Canceled file selection'.tr);
      debugPrint("User canceled file selection");
    }
  }

  void uploadFilesWithId(List<File> files, int id) async {
    try {
      saveLoader.value = true;

      var uri = Uri.parse(InfixApi
          .getStudentHomeWorkUploadFiles); // Replace with your server endpoint
      var request = http.MultipartRequest("POST", uri);

      request.fields['id'] = id.toString();
      request.headers.addAll(GlobalVariable.header);

      for (var file in files) {
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile('files[]', stream, length,
            filename: file.path.split('/').last);

        request.files.add(multipartFile);
      }

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        saveLoader.value = false;
        isUpload.value = false;
        Get.back();
        pickedFileList.clear();
        showBasicSuccessSnackBar(message: decodedResponse["message"]);
      } else {
        saveLoader.value = false;
        showBasicFailedSnackBar(message: decodedResponse["message"]);
      }
    } catch (e, t) {
      saveLoader.value = false;
      debugPrint("$e");
      debugPrint("$t");
    } finally {
      saveLoader.value = false;
    }
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getHomeWorkList();
    });
    super.onInit();
  }
}
