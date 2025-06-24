import 'dart:convert';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/modules/single_chat/controllers/single_chat_controller.dart';
import 'package:infixedu/domain/core/model/chat/conversation_model/single_chat_list_response_model.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherController extends GetxController {
  int? chatOpenId;
  String? chatGroupId;

  // RxBool isTyping = false.obs;
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  onConnectPressed() async {
    try {
      final pusher = PusherChannelsFlutter.getInstance();

      await pusher.init(
        apiKey: Get.find<GlobalRxVariableController>().pusherApiKey.value!,
        cluster: Get.find<GlobalRxVariableController>().pusherClusterKey.value!,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onAuthorizer: onAuthorizer,
        logToConsole: true,
        maxReconnectionAttempts: 0,
      );
    } catch (e, t) {
      debugPrint("ERROR: $e");
      debugPrint("ERROR: $t");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    debugPrint("Connection: $currentState");
  }

  void onError(String? message, int? code, dynamic e) {
    debugPrint("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    debugPrint("onEvent: $event");
    if (event.channelName ==
        'private-single-chat.${Get.find<GlobalRxVariableController>().userId.value}-${Get.find<SingleChatController>().toUserId}') {
      final data = jsonDecode(event.data);

      Get.find<SingleChatController>()
          .singleConversationList
          .add(SingleConversationListData(
            messageId: data["message"]["id"],
            message: data["message"]["message"],
            status: data["message"]["status"],
            messageType: data["message"]["message_type"],
            file: data["message"]["file_name"],
            originalFileName: data["message"]["original_file_name"],
            reply: data["message"]["reply"],
            sender: Get.find<GlobalRxVariableController>().userId.value ==
                data["message"]["from_id"],
            receiver: Get.find<GlobalRxVariableController>().userId.value !=
                data["message"]["from_id"],
          ));
      Get.find<SingleChatController>().singleConversationList.refresh();
    } else if (event.channelName ==
        'private-group-chat.${Get.find<GlobalRxVariableController>().userId.value}-${Get.find<SingleChatController>().toUserId}') {
      final data = jsonDecode(event.data);

      Get.find<SingleChatController>()
          .singleConversationList
          .add(SingleConversationListData(
            messageId: data["message"]["id"],
            message: data["message"]["message"],
            status: data["message"]["status"],
            messageType: data["message"]["message_type"],
            file: data["message"]["file_name"],
            originalFileName: data["message"]["original_file_name"],
            reply: data["message"]["reply"],
            sender: Get.find<GlobalRxVariableController>().userId.value ==
                data["message"]["from_id"],
            receiver: Get.find<GlobalRxVariableController>().userId.value !=
                data["message"]["from_id"],
          ));
      Get.find<SingleChatController>().singleConversationList.refresh();
    }

    if (event.eventName == "client-single-typing") {
      // isTyping(true);

      Future.delayed(const Duration(seconds: 1), () {
        // isTyping(false);
      });
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    final me = pusher.getChannel(channelName)?.me;
    debugPrint("Me::::::::: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    debugPrint("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    debugPrint("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    debugPrint("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    debugPrint("onMemberRemoved: $channelName user: $member");
  }

  dynamic onAuthorizer(
      String channelName, String socketId, dynamic options) async {
    try {
      Map data = {
        'socket_id': socketId,
        'channel_name': channelName,
      };

      debugPrint(data.toString());

      var result = await http.post(
        Uri.parse(InfixApi.chatBroadCastAuth),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': Get.find<GlobalRxVariableController>().token.value!,
        },
        body: 'socket_id=$socketId&channel_name=$channelName',
      );
      return jsonDecode(result.body);
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    }
  }

  chatOpenSingle({required int authUserId, required int chatListId}) async {
    try {
      await pusher.subscribe(
          channelName: 'private-single-chat.$authUserId-$chatListId');
      // channelName: 'private-single-chat.$chatListId-$chatOpenId');
      await pusher.connect();
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    }
  }

  chatOpenGroup({required int authUserId, required String chatListId}) async {
    try {
      await pusher.subscribe(
          channelName: 'private-group-chat.$authUserId-$chatListId');
      await pusher.connect();
    } catch (e, t) {
      debugPrint("ERROR: $e");
      debugPrint("ERROR: $t");
    }
  }

  @override
  void onInit() {
    if (Get.find<GlobalRxVariableController>().pusherApiKey.value != null &&
        Get.find<GlobalRxVariableController>().pusherClusterKey.value != null) {
      onConnectPressed();
    }
    // onConnectPressed();
    super.onInit();
  }
}
