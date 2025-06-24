import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/modules/home/controllers/home_controller.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';
import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/student_online_exam_result_model/student_online_exam_result_response_model.dart';
import '../../../utilities/api_urls.dart';

class ExamResultController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  final selectIndex = RxInt(0);
  RxBool isSelected = false.obs;
  List<OnlineExamResultData> onlineExamResultList = [];

  Future<StudentOnlineExamResultResponseModel> getStudentExamResultList(
      {required int studentId}) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentOnlineExamResult(studentId: studentId),
        header: GlobalVariable.header,
      );

      StudentOnlineExamResultResponseModel
          studentOnlineExamResultResponseModel =
          StudentOnlineExamResultResponseModel.fromJson(response);
      if (studentOnlineExamResultResponseModel.success == true) {
        loadingController.isLoading = false;
        if (studentOnlineExamResultResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < studentOnlineExamResultResponseModel.data!.length;
              i++) {
            onlineExamResultList
                .add(studentOnlineExamResultResponseModel.data![i]);
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
    return StudentOnlineExamResultResponseModel();
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (globalRxVariableController.studentId.value != null) {
        getStudentExamResultList(
          studentId: globalRxVariableController.studentId.value!,
        );
      }
    });

    super.onInit();
  }
}
