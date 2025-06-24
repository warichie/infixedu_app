import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/chat/auth_status_model/chat_auth_active_status_response_model.dart';
import 'package:infixedu/domain/core/model/chat/group_chat_user_list_response_model/group_chat_user_list_response_model.dart';
import 'package:infixedu/domain/core/model/chat/settings/chat_settings_model.dart';
import 'package:infixedu/domain/core/model/chat/single_chat_user_list_response_model/single_chat_user_list_response_model.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  RxBool isSearching = false.obs;
  RxBool singleChatLoader = false.obs;
  RxBool groupChatLoader = false.obs;
  RxBool statusLoader = false.obs;
  RxBool isActive = true.obs;
  RxBool changeStatusLoader = true.obs;
  TabController? tabController;

  /// Active Status

  Rx<StatusInfo> activeStatus =
      StatusInfo(statusColor: 0xFF12AE01, name: "ACTIVE").obs;
  RxInt key = (-1).obs;
  RxString activeColor = ''.obs;
  RxList<StatusInfo> activeStatusList = <StatusInfo>[].obs;
  RxInt tabIndex = 0.obs;

  Rx<ChatStatusModel> dropdownValue =
      ChatStatusModel(statusColor: 0xFF12AE01, name: "ACTIVE").obs;

  List<String> chatType = <String>[
    'Chat',
    'Group Chat',
  ];

  /// Get Single Chat List
  RxBool singleChatListLoader = false.obs;
  RxList<SingleChatUserListData> singleChatList =
      <SingleChatUserListData>[].obs;

  Future<SingleChatUserListResponseModel?> getSingleChatList() async {
    singleChatList.clear();
    try {
      singleChatListLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getSingleChatUserList,
        header: GlobalVariable.header,
      );

      SingleChatUserListResponseModel singleChatListResponseModel =
          SingleChatUserListResponseModel.fromJson(response);
      if (singleChatListResponseModel.success == true) {
        singleChatListLoader.value = false;
        if (singleChatListResponseModel.data?.isNotEmpty ?? false) {
          for (int i = 0; i < singleChatListResponseModel.data!.length; i++) {
            singleChatList.add(singleChatListResponseModel.data![i]);
          }
        }
      } else {
        singleChatListLoader.value = false;
        showBasicFailedSnackBar(
          message: singleChatListResponseModel.message ??
              AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      singleChatListLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      singleChatListLoader.value = false;
    }
    return SingleChatUserListResponseModel();
  }

  /// Get Group CHat List
  RxBool groupChatListLoader = false.obs;
  RxList<GroupChatUserListData> groupChatList = <GroupChatUserListData>[].obs;

  Future<GroupChatUserListResponseModel?> getGroupChatList() async {
    groupChatList.clear();
    try {
      groupChatListLoader.value = true;

      final response = await BaseClient().getData(
        url: InfixApi.getGroupChatUserList,
        header: GlobalVariable.header,
      );

      GroupChatUserListResponseModel groupChatListResponseModel =
          GroupChatUserListResponseModel.fromJson(response);
      if (groupChatListResponseModel.success == true) {
        groupChatListLoader.value = false;
        if (groupChatListResponseModel.data?.isNotEmpty ?? false) {
          for (int i = 0; i < groupChatListResponseModel.data!.length; i++) {
            groupChatList.add(groupChatListResponseModel.data![i]);
          }
        }
      } else {
        groupChatListLoader.value = false;
        showBasicFailedSnackBar(
          message: groupChatListResponseModel.message ??
              AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      groupChatListLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      groupChatListLoader.value = false;
    }
    return GroupChatUserListResponseModel();
  }

  Future<void> changeStatus({
    required int statusKey,
  }) async {
    try {
      changeStatusLoader.value = true;
      final response = await BaseClient().postData(
          url: InfixApi.changeActiveStatus(statusKey: statusKey),
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        changeStatusLoader.value = false;
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Status changed'.tr);
      } else {
        changeStatusLoader.value = false;
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      changeStatusLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      changeStatusLoader.value = false;
    }
  }

  String formatTimeAgo(DateTime date) {
    final now = DateTime.now().toLocal();
    final difference = now.difference(date.toLocal());

    if (difference.inSeconds < 60) {
      return 'a few moments ago'.tr;
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes != 1 ? "minutes ago".tr : "minute ago".tr}';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours != 1 ? "hours ago".tr : "hour ago".tr}';
    } else if (difference.inDays < 30) {
      final days = difference.inDays;
      return '$days ${days != 1 ? "days ago".tr : "day ago".tr}';
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      return '$months ${months != 1 ? "months ago".tr : "month ago".tr}';
    } else {
      final years = difference.inDays ~/ 365;
      return '$years ${years != 1 ? "years ago".tr : "year ago".tr}';
    }
  }

  /// Get Chat Active Status
  Future<ChatAuthActiveStatusResponseModel> getAuthActiveStatus() async {
    try {
      statusLoader.value = true;

      final response = await BaseClient()
          .getData(url: InfixApi.chatStatus, header: GlobalVariable.header);

      ChatAuthActiveStatusResponseModel responseModel =
          ChatAuthActiveStatusResponseModel.fromJson(response);
      if (responseModel.success == true) {
        statusLoader.value = false;

        if (responseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < responseModel.data!.first.statusInfo!.length;
              i++) {
            activeStatusList.add(responseModel.data!.first.statusInfo![i]);
          }

          int index = activeStatusList.indexWhere(
              (element) => element.name == responseModel.data!.first.status);
          activeStatus.value = activeStatusList[index];
          key.value = activeStatusList[index].key!;

          activeColor.value = responseModel.data!.first.color ?? '0xFF12AE01';
        }

        // for(var element in responseModel.data!.first.statusInfo!){
        //   activeStatusList.add(element);
        //   activeStatus.value = response.data;
        //   activeColor.value = responseModel.data!.first.color ?? '0xFF12AE01';
        // }
      } else {
        statusLoader.value = false;
        showBasicFailedSnackBar(
          message: responseModel.message ?? AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      statusLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      statusLoader.value = false;
    }
    return ChatAuthActiveStatusResponseModel();
  }

  /// Get Chat Settings
  Future<void> getChatSettings() async {
    try {
      var request = http.Request('GET', Uri.parse(InfixApi.chatSetting));

      request.headers.addAll(GlobalVariable.header);

      http.StreamedResponse response = await request.send();

      String res = await response.stream.bytesToString();
      Map<String, dynamic> mapResponse = json.decode(res);

      ChatSettingsResponseModel chatSettingsResponseModel =
          ChatSettingsResponseModel.fromJson(mapResponse);

      if (response.statusCode == 200) {
        Get.find<GlobalRxVariableController>().pusherApiKey.value =
            chatSettingsResponseModel.chatSettings?.pusherAppKey;
        Get.find<GlobalRxVariableController>().pusherClusterKey.value =
            chatSettingsResponseModel.chatSettings?.pusherAppCluster;
      } else {
        debugPrint(response.reasonPhrase);
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {}
  }

  @override
  void onInit() {
    // dropdownValue.value = activeStatusList.first;
    // dropdownValue.value = ChatStatusModel(statusColor: int.tryParse(activeColor.value)!, name: activeStatus.value);

    getChatSettings();
    getAuthActiveStatus();
    getSingleChatList();
    getGroupChatList();
    super.onInit();
  }
}

class ChatStatusModel {
  final int statusColor;
  final String name;

  ChatStatusModel({required this.statusColor, required this.name});
}
