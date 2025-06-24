import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/module_data/home_data/home_dummy_data.dart';
import 'package:infixedu/app/database/auth_database.dart';
import 'package:infixedu/app/modules/home/controllers/home_controller.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class ChildHomeController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  HomeController homeController = Get.find();

  List<HomeTileModelClass> homeTileList = studentList;
  final selectIndex = RxInt(-1);
  final AuthDatabase _authDatabase = AuthDatabase.instance;

  Future<PostRequestResponseModel> logout() async {
    LoadingController loadingController = Get.find();
    try {
      final response = await BaseClient().postData(
        url: InfixApi.logout,
        header: GlobalVariable.header,
      );

      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        await _authDatabase.logOut();
        Get.offNamedUntil('/secondary-splash', (route) => false);
        // Get.offNamedUntil('/splash', (route) => false);

        loadingController.isLoading = false;
      } else {
        await _authDatabase.logOut();

        Get.offNamedUntil('/secondary-splash', (route) => false);
        // Get.offNamedUntil('/splash', (route) => false);
        showBasicSuccessSnackBar(
          message:
              postRequestResponseModel.message ?? AppText.somethingWentWrong.tr,
        );

        loadingController.isLoading = false;
      }
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
    } finally {
      await _authDatabase.logOut();

      Get.offNamedUntil('/secondary-splash', (route) => false);
      // Get.offNamedUntil('/splash', (route) => false);

      loadingController.isLoading = false;
    }

    return PostRequestResponseModel();
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getStudentRecord(
          studentId: globalRxVariableController.studentId.value!);
    });
    super.onInit();
  }
}
