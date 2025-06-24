import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/modules/home/controllers/home_controller.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/subject_response_model/subject_response_model.dart';
import '../../../utilities/api_urls.dart';

class SubjectsController extends GetxController {
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  List<SubjectListData> subjectList = [];

  Future<SubjectResponseModel?> getAllSubjectList(
      {required int recordId}) async {
    subjectList.clear();
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentSubjects(recordId),
        header: GlobalVariable.header,
      );

      SubjectResponseModel subjectResponseModel =
          SubjectResponseModel.fromJson(response);
      if (subjectResponseModel.status == true) {
        loadingController.isLoading = false;
        if (subjectResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < subjectResponseModel.data!.length; i++) {
            subjectList.add(subjectResponseModel.data![i]);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
          message:
              subjectResponseModel.message ?? AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
    return SubjectResponseModel();
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (homeController.studentRecordList.isNotEmpty) {
        getAllSubjectList(recordId: homeController.studentRecordList[0].id);
      }
    });

    super.onInit();
  }
}
