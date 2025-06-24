import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/teacher/teacher_leave/teacher_leave_type_list_response_model.dart';
import 'package:get/get.dart';

class TeApplyLeaveController extends GetxController {
  LoadingController loadingController = Get.find();
  RxBool isLoading = false.obs;
  GlobalRxVariableController globalRxVariableController = Get.find();

  TextEditingController applyDateTextController = TextEditingController();
  TextEditingController fromDateTextController = TextEditingController();
  TextEditingController toDateTextController = TextEditingController();
  TextEditingController reasonTextController = TextEditingController();

  bool isValidate = false;
  Rx<File> file = File('').obs;

  RxList<TeacherApplyLeaveTypeData> teacherLeaveTypeList =
      <TeacherApplyLeaveTypeData>[].obs;
  RxBool leaveLoader = false.obs;
  Rx<TeacherApplyLeaveTypeData> leaveTypeInitialValue =
      TeacherApplyLeaveTypeData(id: -1, name: "leave_type").obs;
  RxInt leaveTypeId = 0.obs;

  void changeApplyDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
      canSelectFutureDate: true,
    );

    if (dateTime != null) {
      applyDateTextController.text = dateTime.yyyy_mm_dd;
    }
  }

  void changeFromDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
      canSelectFutureDate: true,
    );

    if (dateTime != null) {
      fromDateTextController.text = dateTime.yyyy_mm_dd;
    }
  }

  void changeToDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
      canSelectFutureDate: true,
    );

    if (dateTime != null) {
      toDateTextController.text = dateTime.yyyy_mm_dd;
    }

    int comparisonResult =
        fromDateTextController.text.compareTo(toDateTextController.text);
    if (comparisonResult == 1) {
      showBasicFailedSnackBar(
          message: 'To date should not be less than From date'.tr);
    }
  }

  bool validation() {
    if (leaveTypeInitialValue.value.id == -1) {
      showBasicFailedSnackBar(message: 'No leave type available'.tr);
      return false;
    }
    if (applyDateTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Apply Date'.tr);
      return false;
    }
    if (fromDateTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select From Date'.tr);
      return false;
    }
    if (toDateTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select To Date'.tr);
      return false;
    }
    if (fromDateTextController.text.compareTo(toDateTextController.text) == 1) {
      showBasicFailedSnackBar(
          message: 'To date should not be less than From date'.tr);
      return false;
    }

    return true;
  }

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

  Future<TeacherLeaveTypeListResponseModel>
      getTeacherApplyLeaveTypeList() async {
    try {
      leaveLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getTeacherLeaveType,
        header: GlobalVariable.header,
      );

      TeacherLeaveTypeListResponseModel teacherLeaveTypeListResponseModel =
          TeacherLeaveTypeListResponseModel.fromJson(response);
      if (teacherLeaveTypeListResponseModel.success == true) {
        leaveLoader.value = false;
        if (teacherLeaveTypeListResponseModel.data!.isNotEmpty) {
          for (var element in teacherLeaveTypeListResponseModel.data!) {
            teacherLeaveTypeList.add(element);
          }
          leaveTypeInitialValue.value = teacherLeaveTypeList.first;
          leaveTypeId.value = teacherLeaveTypeList.first.id!;
        }
      } else {
        leaveLoader.value = false;
        showBasicFailedSnackBar(
          message: teacherLeaveTypeListResponseModel.message ??
              AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      leaveLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      leaveLoader.value = false;
    }

    return TeacherLeaveTypeListResponseModel();
  }

  void applyLeave() async {
    try {
      debugPrint(InfixApi.teacherApplyLeave);
      loadingController.isLoading = true;
      final request =
          http.MultipartRequest('POST', Uri.parse(InfixApi.teacherApplyLeave));
      request.headers['Authorization'] =
          globalRxVariableController.token.value!;

      if (file.value.path.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('attach_file', file.value.path));
      }

      request.fields['type_id'] = leaveTypeId.toString();
      request.fields['apply_date'] = applyDateTextController.text;
      request.fields['leave_from'] = fromDateTextController.text;
      request.fields['leave_to'] = toDateTextController.text;
      request.fields['reason'] = reasonTextController.text;

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);
      debugPrint(decodedResponse.toString());

      if (response.statusCode == 200) {
        loadingController.isLoading = false;
        showBasicSuccessSnackBar(message: decodedResponse['message']);

        applyDateTextController.clear();
        fromDateTextController.clear();
        toDateTextController.clear();
        reasonTextController.clear();
        file.value = File('');
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
      getTeacherApplyLeaveTypeList();
    });

    super.onInit();
  }
}
