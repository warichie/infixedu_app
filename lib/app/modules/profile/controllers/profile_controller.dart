import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/file_downloader/file_download_utils.dart';
import 'package:infixedu/app/utilities/widgets/button/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_browse_icon.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:infixedu/domain/core/model/profile/profile_others_model.dart';
import 'package:infixedu/domain/core/model/profile/profile_parents_model.dart';
import 'package:infixedu/domain/core/model/profile/profile_personal_model.dart';
import 'package:infixedu/domain/core/model/profile/profile_transport_model.dart';
import 'package:infixedu/domain/core/model/students_document_response_model/students_document_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/profile_edit_model/profile_data_controller.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/message/snack_bars.dart';

class ProfileController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();

  PageController profilePageController = PageController();
  ProfileDataController profileDataController =
      Get.put(ProfileDataController());
  LoadingController loadingController = Get.find();
  RxList<ProfileDocuments> documentsDataList = <ProfileDocuments>[].obs;

  Rx<File> file = File('').obs;

  TextEditingController titleTextController = TextEditingController();

  RxInt pageIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxBool deleteLoader = false.obs;
  RxBool saveLoader = false.obs;
  RxBool personalLoader = false.obs;
  RxBool parentLoader = false.obs;
  RxBool transportLoader = false.obs;
  RxBool othersLoader = false.obs;
  RxBool documentLoader = false.obs;
  RxInt permissionForDateOfBirth = 0.obs;

  ProfilePersonal? profilePersonal;
  ProfileParents? profileParents;
  ProfileTransport? profileTransport;
  ProfileOthers? profileOthers;

  ProfilePersonalPermissions? profilePersonalPermissions;
  ProfileParentsPermissions? profileParentsPermissions;
  ProfileTransportPermissions? profileTransportPermissions;
  ProfileOthersPermissions? profileOthersPermissions;
  ProfileDocumentsPermissions? profileDocumentsPermissions;

  ProfilePersonalModel profilePersonalModel = ProfilePersonalModel();
  ProfileParentsModel profileParentsModel = ProfileParentsModel();
  ProfileTransportModel profileTransportModel = ProfileTransportModel();
  ProfileOthersModel profileOthersModel = ProfileOthersModel();
  StudentDocumentsResponseModel studentDocumentsResponseModel =
      StudentDocumentsResponseModel();

  /// For Admin Module
  int? studentIdFromAdmin;

  /// Get Personal Data
  void fetchProfilePersonalData({int? studentId}) async {
    try {
      personalLoader.value = true;

      final response = await BaseClient().getData(
        url: globalRxVariableController.roleId.value == 2
            ? InfixApi.profilePersonal()
            : InfixApi.getSingleStudentProfile(studentId: studentId!),
        header: GlobalVariable.header,
      );
      profilePersonalModel = ProfilePersonalModel.fromJson(response);

      if (profilePersonalModel.success == true) {
        personalLoader.value = false;
        profilePersonal = profilePersonalModel.data?.profilePersonal;
        profilePersonalPermissions = profilePersonalModel.data?.showPermission;

        profileDataController.firstName.value =
            profilePersonal?.firstName ?? '';
        profileDataController.lastName.value = profilePersonal?.lastName ?? '';
        profileDataController.email.value = profilePersonal?.email ?? '';
        profileDataController.phoneNumber.value = profilePersonal?.mobile ?? '';
        profileDataController.dateOfBirth.value =
            profilePersonal?.dateOfBirth ?? '';
        profileDataController.presentAddress.value =
            profilePersonal?.currentAddress ?? '';
        profileDataController.profilePhoto.value =
            profilePersonal?.studentPhoto ?? '';
        permissionForDateOfBirth.value =
            profilePersonalPermissions!.dateOfBirth!;
      } else {
        personalLoader.value = false;
        showBasicFailedSnackBar(message: "${profilePersonalModel.message}");
      }
    } catch (e, t) {
      personalLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      personalLoader.value = false;
    }
  }

  /// Get Parents Data
  void fetchProfileParentsData({int? studentId}) async {
    try {
      parentLoader.value = true;

      final response = await BaseClient().getData(
          url: globalRxVariableController.roleId.value == 2
              ? InfixApi.profileParents()
              : InfixApi.getSingleParentProfile(studentId: studentId!),
          header: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                Get.find<GlobalRxVariableController>().token.value!,
          });

      profileParentsModel = ProfileParentsModel.fromJson(response);

      if (profileParentsModel.success == true) {
        profileParents = profileParentsModel.data?.profileParents;
        profileParentsPermissions = profileParentsModel.data?.showPermission;
        parentLoader.value = false;
      } else {
        parentLoader.value = false;
        showBasicFailedSnackBar(message: "${profileParentsModel.message}");
      }
    } catch (e, t) {
      parentLoader.value = true;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      parentLoader.value = false;
    }
  }

  /// Get Transport Data
  void fetchProfileTransportData({int? studentId}) async {
    try {
      transportLoader.value = true;

      final response = await BaseClient().getData(
        url: globalRxVariableController.roleId.value == 2
            ? InfixApi.profileTransport()
            : InfixApi.getSingleStudentTransportData(studentId: studentId!),
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Get.find<GlobalRxVariableController>().token.value!,
        },
      );

      profileTransportModel = ProfileTransportModel.fromJson(response);

      if (profileTransportModel.success == true) {
        profileTransport = profileTransportModel.data?.profileTransport;
        profileTransportPermissions =
            profileTransportModel.data?.showPermission;
        transportLoader.value = false;
      } else {
        transportLoader.value = false;
        showBasicFailedSnackBar(message: "${profileTransportModel.message}");
      }
    } catch (e, t) {
      transportLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      transportLoader.value = false;
    }
  }

  /// Get Others Data
  void fetchProfileOthersData({int? studentId}) async {
    try {
      othersLoader.value = true;

      final response = await BaseClient().getData(
        url: globalRxVariableController.roleId.value == 2
            ? InfixApi.profileOthers()
            : InfixApi.getSingleStudentOthersData(studentId: studentId!),
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Get.find<GlobalRxVariableController>().token.value!,
        },
      );

      profileOthersModel = ProfileOthersModel.fromJson(response);

      if (profileOthersModel.success == true) {
        profileOthers = profileOthersModel.data?.profileOthers;
        profileOthersPermissions = profileOthersModel.data?.showPermission;
        othersLoader.value = false;
      } else {
        othersLoader.value = false;
        showBasicFailedSnackBar(message: "${profileOthersModel.message}");
      }
    } catch (e, t) {
      othersLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      othersLoader.value = false;
    }
  }

  /// Get Documents Data
  Future<StudentDocumentsResponseModel?> getAllDocumentList(
      {int? studentId}) async {
    try {
      documentLoader.value = true;
      documentsDataList.clear();

      final response = await BaseClient().getData(
        url: globalRxVariableController.roleId.value == 2
            ? InfixApi.profileDocumentGet()
            : InfixApi.getSingleStudentDocumentsData(studentId: studentId!),
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': Get.find<GlobalRxVariableController>().token.value!,
        },
      );

      studentDocumentsResponseModel =
          StudentDocumentsResponseModel.fromJson(response);

      if (studentDocumentsResponseModel.success == true) {
        documentLoader.value = false;
        if (studentDocumentsResponseModel.data!.profileDocuments!.isNotEmpty) {
          for (int i = 0;
              i < studentDocumentsResponseModel.data!.profileDocuments!.length;
              i++) {
            documentsDataList
                .add(studentDocumentsResponseModel.data!.profileDocuments![i]);
          }
        }
        profileDocumentsPermissions =
            studentDocumentsResponseModel.data!.showPermission;
      } else {
        documentLoader.value = false;
        showBasicFailedSnackBar(
            message: studentDocumentsResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      documentLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      documentLoader.value = false;
    }
    return StudentDocumentsResponseModel();
  }

  /// Documents bottom sheet
  void showUploadDocumentsBottomSheet({
    required Function() onTap,
    Function()? onTapForSave,
    Color? bottomSheetBackgroundColor,
  }) {
    Get.bottomSheet(
      Obx(() => Container(
          height: Get.height * 0.45,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
              color: bottomSheetBackgroundColor),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.height * 0.1,
                  width: Get.width,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                      color: AppColors.primaryColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Upload Document".tr,
                        style: AppTextStyle.cardTextStyle14WhiteW500,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: titleTextController,
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "${"Title".tr} *",
                        fillColor: Colors.white,
                      ),
                      10.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        fillColor: Colors.white,
                        hintText: file.value.path.isNotEmpty
                            ? file.value.toString().split('/').last
                            : "${'Select File'.tr} *",
                        readOnly: true,
                        suffixIcon: InkWell(
                          onTap: onTap,
                          child: CustomBrowseIcon(
                            width: 80.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SecondaryButton(
                        width: Get.width * 0.15,
                        title: "Cancel".tr,
                        color: Colors.white,
                        textStyle: AppTextStyle.fontSize13BlackW400,
                        borderColor: AppColors.primaryColor,
                        onTap: () => Get.back(),
                      ),
                      Obx(
                        () => saveLoader.value == true
                            ? const CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              )
                            : SecondaryButton(
                                width: Get.width * 0.2,
                                title: "Save".tr,
                                textStyle: AppTextStyle.textStyle12WhiteW500,
                                onTap: onTapForSave,
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  /// Documents file picker
  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      file.value = File(result.files.single.path!);
    } else {
      showBasicFailedSnackBar(message: 'Canceled file selection'.tr);
      debugPrint("User canceled file selection");
    }
  }

  bool formValidation() {
    if (titleTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: "Title can't be empty".tr);
      return false;
    }

    if (file.value.path.isEmpty) {
      showBasicFailedSnackBar(message: 'Select File'.tr);
      return false;
    }

    return true;
  }

  /// Documents Post
  void uploadDocuments() async {
    try {
      saveLoader.value = true;
      final request = http.MultipartRequest(
          'POST', Uri.parse(InfixApi.studentUploadDocuments));
      request.headers['Authorization'] =
          globalRxVariableController.token.value!;

      if (file.value.path.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('photo', file.value.path));
      }

      if (globalRxVariableController.roleId.value == 1) {
        request.fields['student_id'] = studentIdFromAdmin.toString();
      } else {
        request.fields['student_id'] =
            '${globalRxVariableController.studentId.value}';
      }

      request.fields['title'] = titleTextController.text;

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        saveLoader.value = false;
        Get.back();
        showBasicSuccessSnackBar(message: decodedResponse['message']);

        documentsDataList.add(ProfileDocuments(
            title: decodedResponse['data']['title'],
            file: decodedResponse['data']['file'],
            id: decodedResponse['data']['id']));
        titleTextController.clear();
        file.value = File('');
      } else {
        saveLoader.value = false;
        showBasicSuccessSnackBar(message: decodedResponse['message']);
      }
    } catch (e, t) {
      saveLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      saveLoader.value = false;
    }
  }

  /// Documents Delete
  Future<void> deleteDocument(
      {required int documentId, required int index}) async {
    try {
      deleteLoader.value = true;

      final response = await BaseClient().getData(
          url: InfixApi.profileDocumentDelete(documentId: documentId),
          header: GlobalVariable.header);

      PostRequestResponseModel responseModel =
          PostRequestResponseModel.fromJson(response);

      if (responseModel.success == true) {
        deleteLoader.value = false;
        Get.back();
        documentsDataList.removeAt(index);
        showBasicSuccessSnackBar(message: responseModel.message ?? '');
      } else {
        deleteLoader.value = false;
        showBasicFailedSnackBar(
            message: responseModel.message ?? AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      deleteLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      deleteLoader.value = false;
    }
  }

  void fileDownload({required String url, required String title}) {
    url == ''
        ? showBasicFailedSnackBar(
            message: 'No File Available'.tr,
          )
        : FileDownloadUtils().downloadFiles(url: url, title: title);
  }

  @override
  void onInit() {
    try {
      studentIdFromAdmin = Get.arguments['student_id'];

      globalRxVariableController.roleId.value == 3
          ? fetchProfilePersonalData(
              studentId: globalRxVariableController.studentId.value!)
          : fetchProfilePersonalData(studentId: studentIdFromAdmin);
      globalRxVariableController.roleId.value == 3
          ? fetchProfileParentsData(
              studentId: globalRxVariableController.studentId.value!)
          : fetchProfileParentsData(studentId: studentIdFromAdmin);
      globalRxVariableController.roleId.value == 3
          ? fetchProfileTransportData(
              studentId: globalRxVariableController.studentId.value!)
          : fetchProfileTransportData(studentId: studentIdFromAdmin);
      globalRxVariableController.roleId.value == 3
          ? fetchProfileOthersData(
              studentId: globalRxVariableController.studentId.value!)
          : fetchProfileOthersData(studentId: studentIdFromAdmin);
      globalRxVariableController.roleId.value == 3
          ? getAllDocumentList(
              studentId: globalRxVariableController.studentId.value!)
          : getAllDocumentList(studentId: studentIdFromAdmin);
    } catch (e) {
      log("Error :: $e");
    }
    super.onInit();
  }
}
