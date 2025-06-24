import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/modules/admin_students_search/controllers/admin_students_search_controller.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminAddContentController extends GetxController {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController selectedDateTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  LoadingController loadingController = Get.find();
  GlobalRxVariableController globalRxVariableController = Get.find();
  AdminStudentsSearchController adminStudentsSearchController =
      Get.put(AdminStudentsSearchController());

  RxBool sectionLoader = false.obs;
  RxBool isStudent = false.obs;
  RxBool isAllStudent = false.obs;
  RxBool isStudentSelected = false.obs;
  RxBool isAdminSelected = false.obs;
  RxString contentInitialValue = "Assignment".obs;
  RxString selectedAdminOption = "All Admin".obs;
  RxString selectedStudentOption = "".obs;
  RxString classNullValue = ''.obs;
  RxString sectionNullValue = ''.obs;
  Rx<File> contentFile = File('').obs;

  List<String> availableForList = [];
  RxString contentType = 'as'.obs;
  RxString allClasses = ''.obs;
  RxBool saveLoader = false.obs;

  RxList<String> contentList =
      ["Assignment", "Syllabus", "Other Downloads"].obs;

  void selectDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
      canSelectFutureDate: true,
    );

    if (dateTime != null) {
      selectedDateTextController.text = dateTime.yyyy_mm_dd;
    }
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      contentFile.value = File(result.files.single.path!);
    } else {
      showBasicFailedSnackBar(message: 'Canceled file selection'.tr);
      debugPrint("User canceled file selection");
    }
  }

  bool validation() {
    if (titleTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Title is required'.tr);
      return false;
    } else if (isAllStudent.value == false &&
        isStudentSelected.value == false &&
        isAdminSelected.value == false) {
      showBasicFailedSnackBar(message: 'Available for is required'.tr);
      return false;
    } else if (selectedDateTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Assign date is required'.tr);
      return false;
    }

    return true;
  }

  Future<void> uploadContent() async {
    try {
      saveLoader.value = true;

      debugPrint('${Uri.parse(InfixApi.postAdminContent)}');
      final request = http.MultipartRequest(
          'POST',
          Uri.parse(globalRxVariableController.roleId.value == 1
              ? InfixApi.postAdminContent
              : InfixApi.postTeacherContent));
      request.headers.addAll(GlobalVariable.header);

      if (contentFile.value.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'content_file', contentFile.value.path));
      }

      request.fields['content_title'] = titleTextController.text;
      request.fields['content_type'] = contentType.value;
      request.fields['description'] = descriptionTextController.text;
      request.fields['upload_date'] = selectedDateTextController.text;
      request.fields['available_for[]'] = availableForList.join(',');
      request.fields['all_classes'] = allClasses.value;
      if (isStudentSelected.value && isAllStudent.value == false) {
        request.fields['class'] =
            adminStudentsSearchController.studentClassId.value.toString();
      }
      if (isStudentSelected.value && isAllStudent.value == false) {
        request.fields['section'] =
            adminStudentsSearchController.studentSectionId.value.toString();
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        saveLoader.value = false;
        titleTextController.clear();
        descriptionTextController.clear();
        selectedDateTextController.clear();
        availableForList.clear();
        contentFile.value = File('');
        isAllStudent.value = false;
        isStudentSelected.value = false;
        isAdminSelected.value = false;
        showBasicSuccessSnackBar(message: decodedResponse['message']);
      } else {
        saveLoader.value = false;
        showBasicFailedSnackBar(message: decodedResponse['message']);
      }
    } catch (e, t) {
      saveLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      saveLoader.value = false;
    }
  }
}
