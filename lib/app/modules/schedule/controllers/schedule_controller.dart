import 'package:flutter/material.dart';
import 'package:infixedu/app/modules/home/controllers/home_controller.dart';
import 'package:infixedu/domain/core/model/exam_dropdown_model/exam_dropdown_response_model.dart';
import 'package:infixedu/domain/core/model/student_exam_schedule/student_exam_schedule_model.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/message/snack_bars.dart';

class ScheduleController extends GetxController {
  HomeController homeController = Get.find();

  // List<String> dropdownList = [];
  List<ScheduleData> scheduleList = [];
  RxString recordDropdownValue = "".obs;
  RxBool examLoader = false.obs;
  RxBool scheduleLoader = false.obs;

  RxList<ExamDataList> examList = <ExamDataList>[].obs;
  Rx<ExamDataList> dropdownValue = ExamDataList(id: -1, name: "title").obs;
  RxInt examinationId = 0.obs;

  RxList examDropdownIdList = <int>[].obs;
  RxList examDropdownList = <String>[].obs;

  final selectIndex = RxInt(0);

  void getStudentExamScheduleList(
      {required int examId, required recordId}) async {
    try {
      scheduleList.clear();
      scheduleLoader.value = true;
      final response = await BaseClient().getData(
        url: InfixApi.getStudentExamSchedule(examId, recordId),
        header: GlobalVariable.header,
      );

      StudentExamScheduleResponseModel studentExamScheduleResponseModel =
          StudentExamScheduleResponseModel.fromJson(response);
      if (studentExamScheduleResponseModel.success == true) {
        scheduleLoader.value = false;
        if (studentExamScheduleResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < studentExamScheduleResponseModel.data!.length;
              i++) {
            scheduleList.add(studentExamScheduleResponseModel.data![i]);
          }
        }
      } else {
        scheduleLoader.value = false;
        showBasicFailedSnackBar(
            message: studentExamScheduleResponseModel.message ??
                'Failed to load data'.tr);
      }
    } catch (e, t) {
      scheduleLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      scheduleLoader.value = false;
    }
  }

  void getStudentExamList({required int recordId}) async {
    try {
      examLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentExamList(recordId),
        header: GlobalVariable.header,
      );

      ExamDropdownResponseModel examDropdownResponseModel =
          ExamDropdownResponseModel.fromJson(response);
      if (examDropdownResponseModel.success == true) {
        examLoader.value = false;
        if (examDropdownResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < examDropdownResponseModel.data!.length; i++) {
            examList.add(examDropdownResponseModel.data![i]);
          }
          dropdownValue.value = examList[0];
          examinationId.value = examList[0].id!;
        }
        getStudentExamScheduleList(
            examId: examinationId.value,
            recordId: homeController.studentRecordList[0].id);
      } else {
        examLoader.value = false;
        showBasicFailedSnackBar(
            message:
                examDropdownResponseModel.message ?? 'Failed to load data'.tr);
      }
    } catch (e, t) {
      examLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      examLoader.value = false;
    }
  }

  @override
  void onInit() {
    if (homeController.studentRecordList.isNotEmpty) {
      scheduleLoader.value = true;
      getStudentExamList(recordId: homeController.studentRecordList[0].id);
      recordDropdownValue.value = homeController.studentRecordDropdownList[0];
    }

    super.onInit();
  }
}
