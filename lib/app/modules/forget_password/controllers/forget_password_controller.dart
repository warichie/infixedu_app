import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../../routes/app_pages.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/message/snack_bars.dart';

class ForgetPasswordController extends GetxController {
  LoadingController loadingController = Get.find();

  TextEditingController forgetTextController = TextEditingController();

  void forgetPassword() async {
    try {
      loadingController.isLoading = true;
      final request =
          http.MultipartRequest('POST', Uri.parse(InfixApi.forgetPassword));

      request.fields['email'] = forgetTextController.text;

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = json.decode(responseBody);

      if (response.statusCode == 200) {
        loadingController.isLoading = false;
        showBasicSuccessSnackBar(message: decodedResponse['message']);
        Get.toNamed(Routes.LOGIN);
        forgetTextController.clear();
      } else {
        showBasicFailedSnackBar(message: decodedResponse['message']);
      }
    } catch (e, t) {
      showBasicSuccessSnackBar(message: "$e");
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }

  bool validation() {
    if (forgetTextController.text == '') {
      showBasicFailedSnackBar(message: 'Enter your E-mail first'.tr);
      return false;
    }

    return true;
  }
}
