import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infixedu/app/modules/home/controllers/home_controller.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';
import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/student_online_active_exam_model/online_student_active_exam_response_model.dart';
import '../../../utilities/api_urls.dart';

class ActiveExamController extends GetxController {
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  List<ActiveExamData> onlineActiveExamList = [];
  final selectIndex = RxInt(0);

  Future<StudentOnlineActiveExamResponseModel> getStudentActiveExamList(
      {required int recordId}) async {
    try {
      loadingController.isLoading = true;

      if (homeController.studentRecordList.isNotEmpty) {
        final response = await BaseClient().getData(
          url: InfixApi.getStudentOnlineActiveExam(recordId: recordId),
          header: GlobalVariable.header,
        );

        StudentOnlineActiveExamResponseModel
            studentOnlineActiveExamResponseModel =
            StudentOnlineActiveExamResponseModel.fromJson(response);
        if (studentOnlineActiveExamResponseModel.success == true) {
          loadingController.isLoading = false;
          if (studentOnlineActiveExamResponseModel.data!.isNotEmpty) {
            for (int i = 0;
                i < studentOnlineActiveExamResponseModel.data!.length;
                i++) {
              onlineActiveExamList
                  .add(studentOnlineActiveExamResponseModel.data![i]);
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
    return StudentOnlineActiveExamResponseModel();
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (homeController.studentRecordList.isNotEmpty) {
        getStudentActiveExamList(
          recordId: homeController.studentRecordList.first.id,
        );
      }
    });

    super.onInit();
  }
}
