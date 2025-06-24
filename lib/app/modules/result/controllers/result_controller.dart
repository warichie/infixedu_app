import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infixedu/app/modules/examination/controllers/examination_controller.dart';
import 'package:infixedu/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/student_exam_result/student_exam_result_response_model.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/widgets/loader/loading.controller.dart';

class ResultController extends GetxController {
  LoadingController loadingController = Get.find();
  ExaminationController examinationController = Get.find();
  HomeController homeController = Get.find();
  final selectIndex = RxInt(0);
  RxBool isSelected = false.obs;

  RxString dropdownValue = "".obs;

  List<ExamResult> examResultList = [];
  int? currentExamId;
  int? currentRecordId;

  void _initializeId() {
    if (examinationController.examList.isNotEmpty &&
        homeController.studentRecordList.isNotEmpty) {
      currentExamId = examinationController.examList[0].id;
      currentRecordId = homeController.studentRecordList[0].id;
    }
  }

  void getStudentExamResultList(
      {required int typeId, required int recordId}) async {
    try {
      loadingController.isLoading = true;

      if (examinationController.examList.isNotEmpty &&
          homeController.studentRecordList.isNotEmpty) {
        final response = await BaseClient().getData(
          url: InfixApi.getStudentExamResultList(
              typeId: typeId, recordId: recordId),
          header: GlobalVariable.header,
        );

        StudentExamResultResponseModel studentExamResultResponseModel =
            StudentExamResultResponseModel.fromJson(response);
        if (studentExamResultResponseModel.success == true) {
          loadingController.isLoading = false;
          if (studentExamResultResponseModel.data!.examResult!.isNotEmpty) {
            for (int i = 0;
                i < studentExamResultResponseModel.data!.examResult!.length;
                i++) {
              examResultList
                  .add(studentExamResultResponseModel.data!.examResult![i]);
            }
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

  @override
  void onInit() {
    _initializeId();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (examinationController.examList.isNotEmpty &&
          homeController.studentRecordList.isNotEmpty) {
        dropdownValue.value = examinationController.examDropdownList[0];
        getStudentExamResultList(
            typeId: examinationController.examList[0].id!,
            recordId: homeController.studentRecordList[0].id);
      }
    });

    super.onInit();
  }
}
