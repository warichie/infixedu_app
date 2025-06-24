import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infixedu/app/modules/home/controllers/home_controller.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/syllabus/syllabus_response_model.dart';
import 'package:get/get.dart';

import '../../../utilities/api_urls.dart';

class SyllabusController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();

  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  List<SyllabusList> syllabusList = [];

  void getSyllabusList() async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getSyllabusList(
          globalRxVariableController.studentRecordId.value!,
        ),
        header: GlobalVariable.header,
      );

      SyllabusResponseModel syllabusResponseModel =
          SyllabusResponseModel.fromJson(response);
      if (syllabusResponseModel.success == true) {
        loadingController.isLoading = false;
        if (syllabusResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < syllabusResponseModel.data!.length; i++) {
            syllabusList.add(syllabusResponseModel.data![i]);
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (homeController.studentRecordList.isNotEmpty) {
        getSyllabusList();
      }
    });

    super.onInit();
  }
}
