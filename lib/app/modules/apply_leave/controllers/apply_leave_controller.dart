import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/student_apply_leave_model/student_apply_leave_type_response_model.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/datepicker_dialogue/date_picker.dart';

class ApplyLeaveController extends GetxController {
  LoadingController loadingController = Get.find();
  GlobalRxVariableController globalRxVariableController = Get.find();
  RxBool isLoading = false.obs;

  DateTime now = DateTime.now();

  TextEditingController applyDateTextController = TextEditingController();
  TextEditingController fromDateTextController = TextEditingController();
  TextEditingController toDateTextController = TextEditingController();
  TextEditingController reasonTextController = TextEditingController();

  bool isValidate = false;
  Rx<File> file = File('').obs;

  List<String> leaveTypeDropdownList = [];

  RxInt leaveTypeId = 0.obs;
  Rx<LeaveType> dropdownValue = LeaveType(id: -1, name: "leave_type").obs;

  RxList<LeaveType> applyLeaveTypeList = <LeaveType>[].obs;

  void getStudentApplyLeaveTypeList({required int recordId}) async {
    try {
      isLoading.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getStudentApplyLeaveType(
            roleId: globalRxVariableController.roleId.value!),
        header: GlobalVariable.header,
      );

      StudentApplyLeaveTypeResponseModel studentApplyLeaveTypeResponseModel =
          StudentApplyLeaveTypeResponseModel.fromJson(response);
      if (studentApplyLeaveTypeResponseModel.success == true) {
        isLoading.value = false;
        if (studentApplyLeaveTypeResponseModel.data!.leaveType!.isNotEmpty) {
          for (int i = 0;
              i < studentApplyLeaveTypeResponseModel.data!.leaveType!.length;
              i++) {
            applyLeaveTypeList
                .add(studentApplyLeaveTypeResponseModel.data!.leaveType![i]);
            leaveTypeDropdownList.add(
                studentApplyLeaveTypeResponseModel.data!.leaveType![i].name ??
                    '');
          }
          dropdownValue.value = applyLeaveTypeList[0];
          leaveTypeId.value = applyLeaveTypeList[0].id!;
        }
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(
            message: studentApplyLeaveTypeResponseModel.message ??
                'Failed to load data'.tr);
      }
    } catch (e, t) {
      isLoading.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  void changeApplyDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
      canSelectFutureDate: true,
    );

    if (dateTime != null) {
      applyDateTextController.text = DateFormat('MM/dd/yyyy').format(dateTime);
    }
  }

  void changeFromDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
      canSelectFutureDate: true,
    );

    if (dateTime != null) {
      fromDateTextController.text = DateFormat('MM/dd/yyyy').format(dateTime);
    }
  }

  void changeToDate() async {
    DateTime? dateTime = await DatePickerUtils()
        .pickDate(canSelectPastDate: true, canSelectFutureDate: true);

    if (dateTime != null) {
      toDateTextController.text = DateFormat('MM/dd/yyyy').format(dateTime);
    }
  }

  bool validation() {
    if (dropdownValue.value.id == -1) {
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

  void applyLeave() async {
    try {
      loadingController.isLoading = true;
      final request =
          http.MultipartRequest('POST', Uri.parse(InfixApi.studentApplyLeave));
      request.headers['Authorization'] =
          globalRxVariableController.token.value!;
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';

      if (file.value.path.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('attach_file', file.value.path));
      }

      request.fields['apply_date'] = applyDateTextController.text;
      request.fields['leave_from'] = fromDateTextController.text;
      request.fields['leave_to'] = toDateTextController.text;
      request.fields['reason'] = reasonTextController.text;
      request.fields['student_id'] =
          '${globalRxVariableController.studentId.value}';
      request.fields['leave_type'] = '$leaveTypeId';

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
      if (globalRxVariableController.roleId.value == 2 ||
          globalRxVariableController.roleId.value == 3) {
        getStudentApplyLeaveTypeList(
          recordId: globalRxVariableController.roleId.value!,
        );
      }
    });

    super.onInit();
  }
}
