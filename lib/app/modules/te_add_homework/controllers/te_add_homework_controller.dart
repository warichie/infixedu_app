import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/teacher/teacher_homework_model/teacher_class_list_response_model.dart';
import 'package:infixedu/domain/core/model/teacher/teacher_homework_model/teacher_section_list_response_model.dart';
import 'package:infixedu/domain/core/model/teacher/teacher_homework_model/teacher_subject_list_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TeAddHomeworkController extends GetxController {
  LoadingController loadingController = Get.find();

  TextEditingController assignDateTextController = TextEditingController();
  TextEditingController submissionDateTextController = TextEditingController();
  TextEditingController marksTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  Rx<File> homeworkFile = File('').obs;

  Rx<TeacherClassListData> teacherClassInitialValue =
      TeacherClassListData(id: -1, name: "Class").obs;
  RxList<TeacherClassListData> teacherClassList = <TeacherClassListData>[].obs;
  RxInt teacherClassId = (-1).obs;
  RxBool classLoader = false.obs;

  Rx<TeacherSectionListData> teacherSectionInitialValue =
      TeacherSectionListData(id: -1, name: "Section").obs;
  RxList<TeacherSectionListData> teacherSectionList =
      <TeacherSectionListData>[].obs;
  RxBool sectionLoader = false.obs;
  RxInt teacherSectionId = (-1).obs;

  Rx<TeacherSubjectListData> teacherSubjectInitialValue =
      TeacherSubjectListData(id: -1, name: "Subject").obs;
  RxBool subjectLoader = false.obs;
  RxList<TeacherSubjectListData> teacherSubjectList =
      <TeacherSubjectListData>[].obs;
  RxInt teacherSubjectId = (-1).obs;

  /// Class, Subject & section Api call

  /// Add homework dropdown class list
  Future<TeacherClassListResponseModel> getTeacherClassList() async {
    try {
      teacherClassList.clear();
      classLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getTeacherAddHomeworkClassList,
        header: GlobalVariable.header,
      );

      TeacherClassListResponseModel teacherClassListResponseModel =
          TeacherClassListResponseModel.fromJson(response);

      if (teacherClassListResponseModel.success == true) {
        classLoader.value = false;
        if (teacherClassListResponseModel.data!.isNotEmpty) {
          for (var element in teacherClassListResponseModel.data!) {
            teacherClassList.add(element);
          }
          teacherClassInitialValue.value = teacherClassList[0];
          teacherClassId.value = teacherClassListResponseModel.data!.first.id!;
          getTeacherSubjectList(classId: teacherClassId.value);
        }
      } else {
        classLoader.value = false;
        showBasicFailedSnackBar(
            message: teacherClassListResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      classLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      classLoader.value = false;
    }

    return TeacherClassListResponseModel();
  }

  /// Add homework dropdown Subject list
  Future<TeacherSubjectListResponseModel> getTeacherSubjectList(
      {required int classId}) async {
    try {
      teacherSubjectList.clear();
      subjectLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getTeacherAddHomeworkSubjectList(classId: classId),
        header: GlobalVariable.header,
      );

      TeacherSubjectListResponseModel teacherSubjectListResponseModel =
          TeacherSubjectListResponseModel.fromJson(response);

      if (teacherSubjectListResponseModel.success == true) {
        subjectLoader.value = false;
        if (teacherSubjectListResponseModel.data!.isNotEmpty) {
          for (var element in teacherSubjectListResponseModel.data!) {
            teacherSubjectList.add(element);
          }
          teacherSubjectInitialValue.value = teacherSubjectList.first;
          teacherSubjectId.value = teacherSubjectList.first.id!;
          getTeacherSectionList(
              classId: teacherClassId.value, subjectId: teacherSubjectId.value);
        }
      } else {
        subjectLoader.value = false;
        showBasicFailedSnackBar(
            message: teacherSubjectListResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      subjectLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      subjectLoader.value = false;
    }

    return TeacherSubjectListResponseModel();
  }

  /// Add homework dropdown Section list
  Future<TeacherSectionListResponseModel> getTeacherSectionList(
      {required int classId, required int subjectId}) async {
    try {
      teacherSectionList.clear();
      sectionLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getTeacherAddHomeworkSectionList(
          classId: classId,
          subjectId: subjectId,
        ),
        header: GlobalVariable.header,
      );

      TeacherSectionListResponseModel teacherSectionListResponseModel =
          TeacherSectionListResponseModel.fromJson(response);

      if (teacherSectionListResponseModel.success == true) {
        sectionLoader.value = false;
        if (teacherSectionListResponseModel.data!.isNotEmpty) {
          for (var element in teacherSectionListResponseModel.data!) {
            teacherSectionList.add(element);
          }
          teacherSectionId.value = teacherSectionList[0].id!;
          teacherSectionInitialValue.value = teacherSectionList[0];
        }
      } else {
        sectionLoader.value = false;
        showBasicFailedSnackBar(
            message: teacherSectionListResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      sectionLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      sectionLoader.value = false;
    }

    return TeacherSectionListResponseModel();
  }

  void assignDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
      canSelectFutureDate: true,
    );

    if (dateTime != null) {
      assignDateTextController.text = dateTime.yyyy_mm_dd;
    }
  }

  void submissionDate() async {
    DateTime? dateTime = await DatePickerUtils()
        .pickDate(canSelectFutureDate: true, canSelectPastDate: true);

    if (dateTime != null) {
      submissionDateTextController.text = dateTime.yyyy_mm_dd;
    }

    if (assignDateTextController.text
            .compareTo(submissionDateTextController.text) ==
        1) {
      showBasicFailedSnackBar(
          message: 'Assign date must be less than Submission date'.tr);
    }
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      homeworkFile.value = File(result.files.single.path!);
    } else {
      showBasicFailedSnackBar(message: 'Canceled file selection'.tr);
      debugPrint("User canceled file selection");
    }
  }

  bool validation() {
    if (teacherClassId.value == -1) {
      showBasicFailedSnackBar(message: 'Select Class'.tr);
      return false;
    }
    if (teacherSubjectId.value == -1) {
      showBasicFailedSnackBar(message: 'Select Subject'.tr);
      return false;
    }
    if (teacherSectionId.value == -1) {
      showBasicFailedSnackBar(message: 'Select Section'.tr);
      return false;
    }
    if (assignDateTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Assign Date'.tr);
      return false;
    }
    if (submissionDateTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Submission Date'.tr);
      return false;
    }

    if (marksTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Add Marks'.tr);
      return false;
    }
    if (descriptionTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Add Description'.tr);
      return false;
    }
    if (assignDateTextController.text
            .compareTo(submissionDateTextController.text) ==
        1) {
      showBasicFailedSnackBar(
          message: 'Assign date must be less than Submission date'.tr);
      return false;
    }

    return true;
  }

  Future<void> addTeacherHomework() async {
    try {
      loadingController.isLoading = true;

      final request =
          http.MultipartRequest('POST', Uri.parse(InfixApi.teacherAddHomework));
      request.headers.addAll(GlobalVariable.header);

      if (homeworkFile.value.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'homework_file', homeworkFile.value.path));
      }

      request.fields['class_id'] = teacherClassId.value.toString();
      request.fields['subject_id'] = teacherSubjectId.value.toString();
      request.fields['section_id'] = teacherSectionId.value.toString();
      request.fields['assign_date'] = assignDateTextController.text;
      request.fields['submission_date'] = submissionDateTextController.text;
      request.fields['marks'] = marksTextController.text;
      request.fields['description'] = descriptionTextController.text;

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        loadingController.isLoading = false;
        assignDateTextController.clear();
        descriptionTextController.clear();
        submissionDateTextController.clear();
        marksTextController.clear();
        homeworkFile.value = File('');

        showBasicSuccessSnackBar(message: decodedResponse['message']);
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(message: decodedResponse['message']);
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTeacherClassList().then(
        (value) {
          if (teacherClassList.isNotEmpty) {
            getTeacherSubjectList(classId: teacherClassId.value).then(
              (value) {
                if (teacherSubjectList.isNotEmpty) {
                  getTeacherSectionList(
                      classId: teacherClassId.value,
                      subjectId: teacherSubjectId.value);
                }
              },
            );
          }
        },
      );
    });

    super.onInit();
  }
}
