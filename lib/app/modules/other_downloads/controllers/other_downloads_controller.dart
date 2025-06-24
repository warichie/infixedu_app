import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/domain/core/model/student_others_download_model/student_others_download_response_model.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../utilities/api_urls.dart';

class OtherDownloadsController extends GetxController {
  List<StudentOthersDownloadData> studentOthersDownloadList = [];
  LoadingController loadingController = Get.find();
  GlobalRxVariableController globalRxVariableController = Get.find();
  void getStudentOthersDownloadList() async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentOthersDownloadList(
          globalRxVariableController.studentRecordId.value!,
        ),
        header: GlobalVariable.header,
      );

      StudentOthersDownloadResponseModel studentOthersDownloadResponseModel =
          StudentOthersDownloadResponseModel.fromJson(response);
      if (studentOthersDownloadResponseModel.success == true) {
        loadingController.isLoading = false;
        if (studentOthersDownloadResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < studentOthersDownloadResponseModel.data!.length;
              i++) {
            studentOthersDownloadList
                .add(studentOthersDownloadResponseModel.data![i]);
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
      getStudentOthersDownloadList();
    });
    super.onInit();
  }
}
