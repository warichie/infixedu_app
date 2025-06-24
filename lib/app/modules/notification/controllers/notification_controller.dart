import 'package:flutter/material.dart';
import 'package:infixedu/app/database/auth_database.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/core/model/default_response_model/default_response_model.dart';
import 'package:infixedu/domain/core/model/notification/notification_model.dart';
import 'package:get/get.dart';

import '../../../../domain/base_client/base_client.dart';
import '../../../utilities/message/snack_bars.dart';

class NotificationController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  RxBool isLoading = false.obs;
  LoadingController loadingController = Get.find();

  RxList unReadNotificationList = [].obs;

  // int unreadNotificationCount = 0;

  void fetchNotifications() async {
    isLoading.value = true;

    try {
      final res = await BaseClient().getData(
        url: InfixApi.notificationList,
        header: GlobalVariable.header,
      );

      NotificationModel notificationModel = NotificationModel.fromJson(res);

      if (notificationModel.success == true) {
        AuthDatabase authDatabase = AuthDatabase.instance;
        authDatabase.saveUnReadNotification(
            unReadNotification:
                notificationModel.data?.unreadNotificationsCount ?? 0);
        globalRxVariableController.notificationCount.value =
            notificationModel.data?.unreadNotificationsCount ?? 0;
        if (notificationModel.data?.unreadNotifications != null &&
            notificationModel.data!.unreadNotifications!.isNotEmpty) {
          for (int i = 0;
              i < notificationModel.data!.unreadNotifications!.length;
              i++) {
            unReadNotificationList
                .add(notificationModel.data!.unreadNotifications![i]);
          }
        }

        isLoading.value = false;
      } else {
        isLoading.value = false;
        showBasicFailedSnackBar(message: "${notificationModel.message}");
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      isLoading.value = false;
    }
  }

  void readAllNotifications() async {
    AuthDatabase authDatabase = AuthDatabase.instance;

    try {
      loadingController.isLoading = true;
      final response = await BaseClient().getData(
        url: InfixApi.readAllNotification,
        header: GlobalVariable.header,
      );

      DefaultResponseModel defaultResponseModel =
          DefaultResponseModel.fromJson(response);

      if (defaultResponseModel.success == true) {
        unReadNotificationList.clear();
        globalRxVariableController.notificationCount.value = 0;
        authDatabase.saveUnReadNotification(unReadNotification: 0);
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }
}
