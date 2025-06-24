import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/domain/core/model/student_routine_model/student_routine_response_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../utilities/api_urls.dart';

class RoutineController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();

  TabController? tabController;
  List<ClassRoutine> classRoutineList = [];
  LoadingController loadingController = Get.find();
  RxInt selectIndex =
      daysOfWeek.indexOf(DateFormat.E().format(DateTime.now())).obs;

  String formattedDate = DateFormat("dd MMMM yyyy").format(DateTime.now());
  //String today = DateFormat.E().format(DateTime.now());

  void getRoutineList() async {
    try {
      if (globalRxVariableController.roleId.value != 4 &&
          globalRxVariableController.studentRecordId.value == null) {
        return;
      }
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: globalRxVariableController.roleId.value == 4
            ? InfixApi.getTeacherMyRoutineList(
                userId: globalRxVariableController.userId.value!,
              )
            : InfixApi.getStudentRoutineList(
                globalRxVariableController.studentRecordId.value!,
              ),
        header: GlobalVariable.header,
      );

      log("Response :::: $response");

      StudentRoutineResponseModel studentRoutineResponseModel =
          StudentRoutineResponseModel.fromJson(response);
      if (studentRoutineResponseModel.success == true) {
        loadingController.isLoading = false;
        if (studentRoutineResponseModel.data.classRoutines.isNotEmpty) {
          for (int i = 0;
              i < studentRoutineResponseModel.data.classRoutines.length;
              i++) {
            classRoutineList
                .add(studentRoutineResponseModel.data.classRoutines[i]);
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

  // void selectTab() {
  //
  //   selectIndex.value = daysOfWeek.indexOf(today);
  //
  // }

  @override
  void onInit() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getRoutineList();
      // selectTab();
    });
    super.onInit();
  }
}

List<String> daysOfWeek = <String>[
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];
