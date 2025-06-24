import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class AdminAddDormitoryController extends GetxController {
  LoadingController loadingController = Get.find();

  TextEditingController dormitoryNameController = TextEditingController();
  TextEditingController dormitoryIntakeController = TextEditingController();
  TextEditingController dormitoryAddressController = TextEditingController();
  TextEditingController dormitoryDescriptionController =
      TextEditingController();

  RxString dormitoryType = ''.obs;

  RxString dropdownValue = 'Boy'.obs;
  List<String> dropdownList = ['Boy', 'Girl'];

  bool validation() {
    if (dormitoryNameController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Dormitory Name'.tr);
      return false;
    }

    if (dormitoryIntakeController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Intake'.tr);
      return false;
    }

    if (dormitoryAddressController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Address'.tr);
      return false;
    }

    return true;
  }

  void addDormitory() async {
    try {
      loadingController.isLoading = true;
      final response = await BaseClient().postData(
        url: InfixApi.addDormitoryFromAdmin,
        header: GlobalVariable.header,
        payload: {
          "dormitory_name": dormitoryNameController.text,
          "type": dormitoryType.toString(),
          "address": dormitoryAddressController.text,
          "intake": dormitoryIntakeController.text,
          "description": dormitoryDescriptionController.text
        },
      );

      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);
      if (postRequestResponseModel.success == true) {
        loadingController.isLoading = false;
        dormitoryNameController.clear();
        dormitoryAddressController.clear();
        dormitoryIntakeController.clear();
        dormitoryDescriptionController.clear();
        showBasicSuccessSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong'.tr);
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }
}
