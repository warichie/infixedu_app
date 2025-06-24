import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxBool passLoader = false.obs;

  RxBool currentPassObscureText = true.obs;
  RxBool newPassObscureText = true.obs;
  RxBool confirmPassObscureText = true.obs;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<PostRequestResponseModel> changePassword() async {
    try {
      passLoader.value = true;

      final response = await BaseClient().postData(
          url: InfixApi.changePassword,
          header: GlobalVariable.header,
          payload: {
            'current_password': currentPasswordController.text,
            'new_password': newPasswordController.text,
            'confirm_password': confirmPasswordController.text,
            'id': Get.find<GlobalRxVariableController>().userId.value,
          });

      PostRequestResponseModel responseModel =
          PostRequestResponseModel.fromJson(response);

      if (responseModel.success == true) {
        passLoader.value = false;

        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        showBasicSuccessSnackBar(message: responseModel.message ?? '');
      } else {
        passLoader.value = false;
        showBasicFailedSnackBar(
          message: responseModel.message ?? AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      passLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      passLoader.value = false;
    }

    return PostRequestResponseModel();
  }

  bool validation() {
    if (newPasswordController.text != confirmPasswordController.text) {
      showBasicFailedSnackBar(
          message: 'New & Confirm password must be same'.tr);
      return false;
    }

    if (currentPasswordController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Password can not be empty'.tr);
      return false;
    }

    return true;
  }
}
