import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/modules/chat/controllers/chat_controller.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/chat/blocked_users_list_response_model/blocked_users_list_response_model.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class BlockedUsersController extends GetxController {
  ChatController chatController = Get.find();

  List<BlockedUsersData> blockedUsersData = [];
  RxBool blockedUsersDataLoader = false.obs;
  RxBool blockLoaded = false.obs;

  Future<BlockedUsersListResponseModel?> blockedUsersList() async {
    blockedUsersData.clear();
    try {
      blockedUsersDataLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.blockedChatUser,
        header: GlobalVariable.header,
      );

      BlockedUsersListResponseModel blockedUsersListResponseModel =
          BlockedUsersListResponseModel.fromJson(response);
      if (blockedUsersListResponseModel.success == true) {
        blockedUsersDataLoader.value = false;
        if (blockedUsersListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < blockedUsersListResponseModel.data!.length; i++) {
            blockedUsersData.add(blockedUsersListResponseModel.data![i]);
          }
        }
      } else {
        blockedUsersDataLoader.value = false;
        showBasicFailedSnackBar(
          message: blockedUsersListResponseModel.message ??
              AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      blockedUsersDataLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      blockedUsersDataLoader.value = false;
    }
    return BlockedUsersListResponseModel();
  }

  /// Block a single user
  Future<void> blockSingleUser(
      {required String type, required int userId}) async {
    try {
      blockLoaded.value = true;
      final response = await BaseClient().postData(
          url: InfixApi.blockSingleUser(type: type, userId: userId),
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        blockLoaded.value = false;
        chatController.singleChatList.clear();
        chatController.getSingleChatList();
        Get.back();

        showBasicSuccessSnackBar(
            message:
                postRequestResponseModel.message ?? 'Operation Successful'.tr);
      } else {
        blockLoaded.value = false;
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      blockLoaded.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      blockLoaded.value = false;
    }
  }

  @override
  void onInit() {
    blockedUsersList();
    super.onInit();
  }
}
